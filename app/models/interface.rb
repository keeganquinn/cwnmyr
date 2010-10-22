#--
# $Id: interface.rb 389 2007-05-27 08:15:27Z keegan $
# Copyright 2004-2007 Keegan Quinn
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#++

# An Interface instance represents a network interface or connection with
# a relationship to a Host instance.
#
# It is further differentiated by InterfaceType and Status relationships as
# well as the ability to track geospatial data via InterfacePoint instances
# and configuration details via InterfaceProperty and WirelessInterface
# instances.
class Interface < ActiveRecord::Base
  default_scope :order => 'host_id, status_id, code ASC'

  belongs_to :host
  belongs_to :type, {
    :class_name => 'InterfaceType', :foreign_key => 'interface_type_id'
  }
  belongs_to :status
  has_many :points, {
    :class_name => 'InterfacePoint', :foreign_key => 'interface_id'
  }
  has_many :properties, {
    :class_name => 'InterfaceProperty', :foreign_key => 'interface_id'
  }
  has_one :wireless_interface

  validates_presence_of :host_id
  validates_presence_of :interface_type_id
  validates_presence_of :status_id
  validates_length_of :code, :minimum => 1
  validates_length_of :code, :maximum => 64
  validates_uniqueness_of :code, :scope => :host_id
  validates_format_of :code, :with => %r{^[-_a-zA-Z0-9]+$},
    :message => 'contains unacceptable characters',
    :if => Proc.new { |o| o.code && o.code.size > 1 }

  # TODO - look at using NetAddr::CIDR here

  validates_each :ipv4_masked_address do |record, attr, value|
    if value.blank?
      record.errors.add attr, 'is missing'
    else
      unless value =~ %r{^(\d+)\.(\d+)\.(\d+)\.(\d+)/(\d+)$}
        record.errors.add attr, 'is not formatted correctly'
      else
        if $1.to_i < 0 || $1.to_i > 255 || $2.to_i < 0 || $2.to_i > 255 ||
            $3.to_i < 0 || $3.to_i > 255 || $4.to_i < 0 || $4.to_i > 255 ||
            $5.to_i < 0 || $5.to_i > 32
          record.errors.add attr, 'is out of range'
        end
      end
    end
  end
  validates_each :ipv6_masked_address do |record, attr, value|
    unless value.blank?
      unless value =~ %r{^([:0-9a-fA-F]*):([:0-9a-fA-F]*):([:0-9a-fA-F]*)/(\d+)$}
        record.errors.add attr, 'is not formatted correctly'
      else
        if $4.to_i < 0 || $4.to_i > 128
          record.errors.add attr, 'is out of range'
        end
      end
    end
  end
  validates_format_of :mac,
    :with => %r{^[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]$},
    :message => 'is not a valid MAC address',
    :if => Proc.new { |o| o.mac && o.mac.size > 0 }
  validates_length_of :name, :maximum => 128,
    :if => Proc.new { |o| o.name && o.name.size > 0 }

  # Converts the values of the +code+ and +name+ attributes into a
  # link-friendly String instance.
  def display_name
    name.blank? ? '(' + code + ')' : '(' + code + ') ' + name
  end

  # Converts the value of the <tt>ipv4_masked_address</tt> attribute into a
  # CIDR notation String instance.
  def ipv4_address
    ipv4_masked_address =~ %r{^(\d+)\.(\d+)\.(\d+)\.(\d+)/(\d+)$}
    $1 + '.' + $2 + '.' + $3 + '.' + $4
  end

  # Converts the value of the <tt>ipv4_masked_address</tt> attribute into a
  # CIDR prefix length.
  def ipv4_prefix
    ipv4_masked_address =~ %r{^(\d+)\.(\d+)\.(\d+)\.(\d+)/(\d+)$}
    $5
  end

  # Converts the value of the <tt>ipv4_masked_address</tt> attribute into an
  # Ipv4Calculator::Subnet instance.
  def ipv4_calculated_subnet
    @ipv4_calculated_subnet ||= Ipv4Calculator::Subnet.new(ipv4_masked_address)
  end

  # Converts the value of the <tt>ipv4_masked_address</tt> attribute into an
  # IPv4 dotted-quad network address.
  def ipv4_network
    ipv4_calculated_subnet.network
  end

  # Converts the value of the <tt>ipv4_masked_address</tt> attribute into an
  # IPv4 dotted-quad network mask.
  def ipv4_netmask
    ipv4_calculated_subnet.netmask
  end

  # Converts the value of the <tt>ipv4_masked_address</tt> attribute into an
  # IPv4 dotted-quad broadcast address.
  def ipv4_broadcast
    ipv4_calculated_subnet.broadcast
  end

  # Determines if this Interface instance has a static IPv4 address.
  # It is assumed dynamic if the host address matches the network address.
  def ipv4_static_address?
    ipv4_network != ipv4_address
  end

  # Finds neighboring Interface instances based on IPv4 network
  # configuration data.
  def ipv4_neighbors
    unless @current_ipv4_neighbors
      @current_ipv4_neighbors = []

      host.node.hosts.each do |node_host|
        next if node_host == host

        node_host.interfaces.each do |interface|
          if Ipv4Calculator::subnet_neighbor_match?(ipv4_masked_address, interface.ipv4_masked_address)
            if interface.type.wireless && type.wireless
              if interface.wireless_interface && wireless_interface &&
                  (interface.wireless_interface.essid ==
                     wireless_interface.essid) &&
                  (interface.wireless_interface.channel ==
                     wireless_interface.channel)
                @current_ipv4_neighbors.push interface
              end
            end

            unless interface.type.wireless || type.wireless
              @current_ipv4_neighbors.push interface
            end
          end
        end
      end
    end

    @current_ipv4_neighbors
  end

  def ipv6_static_address? #:nodoc:
    raise NotImplementedError.new('IPv6 calculations not supported.')
  end

  def ipv6_neighbors #:nodoc:
    raise NotImplementedError.new('IPv6 calculations not supported.')
  end

  # This method calculates the median average center point of this
  # Interface instance based on data from the InterfacePoint model.
  def average_point
    latitude, longitude, height, error, i = 0.0, 0.0, 0.0, 0.0, 0

    points.each do |point|
      i += 1
      latitude += point.latitude
      longitude += point.longitude
      height += point.height
      error += point.error
    end

    return nil if i == 0

    {
      :latitude => latitude./(i),
      :longitude => longitude./(i),
      :height => height./(i),
      :error => error./(i)
    }
  end
end
