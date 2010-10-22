#--
# $Id: node.rb 361 2007-05-16 00:52:06Z keegan $
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

# A Node instance represents a physical location at a scale somewhere
# between that of the Zone model and that of the InterfacePoint model.
#
# This model includes dependencies on User, Status and Zone instances
# and has relationships with NodeAuthorization, NodeComment, Host,
# NodeLink, NodeLog and NodeMaintainer instances.
class Node < ActiveRecord::Base
  default_scope :order => 'zone_id, name ASC'

  belongs_to :user
  belongs_to :status
  belongs_to :zone
  has_many :authorizations, :class_name => 'NodeAuthorization'
  has_many :comments, :class_name => 'NodeComment'
  has_many :hosts
  has_many :links, :class_name => 'NodeLink'
  has_many :logs, :class_name => 'NodeLog'
  has_many :maintainers, :class_name => 'NodeMaintainer'

  validates_presence_of :user_id
  validates_presence_of :status_id
  validates_presence_of :zone_id
  validates_length_of :code, :minimum => 1
  validates_length_of :code, :maximum => 64
  validates_uniqueness_of :code
  validates_format_of :code, {
    :with => %r{^[-_a-zA-Z0-9]+$},
    :message => 'contains unacceptable characters',
    :if => Proc.new { |o| o.code && o.code.size > 1 }
  }
  validates_length_of :name, :minimum => 1
  validates_length_of :name, :maximum => 128
  validates_uniqueness_of :name
  validates_format_of :email, {
    :with => %r{^([\w\-\.\#\$%&!?*\'=(){}|~_]+)@([0-9a-zA-Z\-\.\#\$%&!?*\'=(){}|~]+)+$},
    :message => 'must be a valid email address',
    :if => Proc.new { |o| o.email && o.email.size > 1 }
  }
  validates_length_of :email, :maximum => 128, :allow_nil => true

  # Converts the value of the +name+ attribute into a link-friendly
  # String instance.
  def stripped_name
    self.name.gsub(/<[^>]*>/,'').to_url
  end

  # This method constructs an RGL::AdjacencyGraph instance based on this
  # Node instance, including related Interface instances and IPv4 neighbor
  # relationships.
  def graph
    g = RGL::AdjacencyGraph.new

    hosts.each do |host|
      host.interfaces.each do |interface|
        g.add_edge(host.name, host.name + ': ' + interface.code)

        interface.ipv4_neighbors.each do |neighbor|
          g.add_edge(host.name + ': ' + interface.code,
                     neighbor.host.name + ': ' + neighbor.code)
        end
      end
    end

    g
  end

  # This method retrieves the primary Host instance which is related
  # to this Node instance, or +nil+ if there is none.
  def primary_host
    return nil if hosts.empty?
    return hosts.first if hosts.size == 1

    return nil unless t = HostPropertyType.find_by_code('primary')

    hosts.each do |host|
      if property = host.properties.find_by_host_property_type_id(t.id)
        return host
      end
    end

    return nil
  end

  # This method calculates the median average center point of this Node
  # instance based on data from the Host#average_point method.
  def average_point
    latitude, longitude, height, error, i = 0.0, 0.0, 0.0, 0.0, 0

    hosts.each do |host|
      if point = host.average_point
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

  # Looks up an active flagged Node instance by the provided +code+.
  def self.find_active_by_code(code)
    self.find(:first, :conditions => [ "code = ? AND expose = ?", code, true ])
  end

  protected

  before_validation_on_create :set_defaults

  # Set default values.
  def set_defaults
    self.code = self.stripped_name if self.code.blank?
  end
end
