#--
# $Id: host.rb 361 2007-05-16 00:52:06Z keegan $
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

# Each Host instance represents a network device which is used at a Node.
# It includes dependencies on a HostType instance and a Status instance.
#
# Other relationships include Interface, HostLog, HostProperty
# and HostService instances.
class Host < ActiveRecord::Base
  default_scope :order => 'node_id, name ASC'

  belongs_to :node
  belongs_to :type, :class_name => 'HostType', :foreign_key => 'host_type_id'
  belongs_to :status
  has_many :interfaces, :order => 'code ASC'
  has_many :logs, :class_name => 'HostLog', :foreign_key => 'host_id'
  has_many :properties, {
    :class_name => 'HostProperty',
    :foreign_key => 'host_id'
  }
  has_many :services, :class_name => 'HostService', :foreign_key => 'host_id'

  validates_presence_of :node_id
  validates_presence_of :host_type_id
  validates_presence_of :status_id
  validates_length_of :name, :minimum => 1
  validates_length_of :name, :maximum => 64
  validates_uniqueness_of :name, :scope => :node_id
  validates_uniqueness_of :name, :if => Proc.new { |o| o.top_level_hostname? }
  validates_format_of :name, :with => %r{^[-a-zA-Z0-9]+$},
    :message => 'contains unacceptable characters',
    :if => Proc.new { |o| o.name.size > 1 }

  # This method constructs an RGL::AdjacencyGraph instance based on this
  # Host instance, including related Interface instances and IPv4 neighbor
  # relationships.
  def graph
    g = RGL::AdjacencyGraph.new

    interfaces.each do |interface|
      g.add_edge(name, name + ': ' + interface.code)

      interface.ipv4_neighbors.each do |neighbor|
        g.add_edge(name + ': ' + interface.code,
                   neighbor.host.name + ': ' + neighbor.code)
      end
    end

    g
  end

  # This method retrieves the primary Interface instance which is related
  # to this Host instance, or +nil+ if there is none.
  def primary_interface
    return nil if interfaces.empty?
    return interfaces.first if interfaces.size == 1

    return nil unless t = InterfacePropertyType.find_by_code('primary')

    interfaces.each do |interface|
      if property = interface.properties.find_by_interface_property_type_id(t.id)
        return interface
      end
    end

    return nil
  end

  # This method retrieves the external Interface instance which is related
  # to this Host instance, or +nil+ if there is none.
  def external_interface
    return nil if interfaces.empty?

    return nil unless t = InterfacePropertyType.find_by_code('default_route')

    interfaces.each do |interface|
      if property = interface.properties.find_by_interface_property_type_id(t.id)
        return interface
      end
    end

    return nil
  end

  # This method calculates the median average center point of this Host
  # instance based on data from the Interface#average_point method.
  def average_point
    latitude, longitude, height, error, i = 0.0, 0.0, 0.0, 0.0, 0

    interfaces.each do |interface|
      if point = interface.average_point
        i += 1
        latitude += point[:latitude]
        longitude += point[:longitude]
        height += point[:height]
        error += point[:error]
      end
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
