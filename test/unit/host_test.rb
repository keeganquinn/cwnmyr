#--
# $Id: host_test.rb 2753 2006-06-16 08:57:06Z keegan $
# Copyright 2004-2006 Keegan Quinn
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

require 'test_helper'

class HostTest < ActiveSupport::TestCase
  fixtures :hosts, :host_properties, :host_property_types, :host_types, :interfaces, :interface_properties, :interface_property_types, :nodes, :statuses

  def setup
    @host = Host.new

    @host.node = nodes(:first)
    @host.type = host_types(:first)
    @host.status = statuses(:first)
    @host.name = 'unittest'
  end

  def test_create_read_update_delete
    assert(@host.save)

    read_host = nodes(:first).hosts.find_by_name 'unittest'

    assert_equal(@host.status, read_host.status)

    @host.description = 'Unit test'

    assert(@host.save)

    assert(@host.destroy)
  end

  def test_associations
    assert_kind_of(Node, hosts(:first).node)
    assert_kind_of(HostType, hosts(:first).type)
    assert_kind_of(Status, hosts(:first).status)
  end

  def test_validates_presence_of_node_id
    @host.node = nil
    assert !@host.save
  end

  def test_validates_presence_of_host_type_id
    @host.type = nil
    assert !@host.save
  end

  def test_validates_presence_of_status_id
    @host.status = nil
    assert !@host.save
  end

  def test_validates_length_of_name
    @host.name = ''
    assert !@host.save
  end

  def test_validates_uniqueness_of_name
    @host.name = 'firsttest'
    assert !@host.save
  end

  def test_validates_format_of_name
    @host.name = 'unit test'
    assert !@host.save
  end

  def test_graph
    assert_kind_of(RGL::AdjacencyGraph, hosts(:first).graph)
  end

  def test_primary_interface
    assert_kind_of Interface, hosts(:first).primary_interface
    assert_nil hosts(:second).primary_interface

    interface = hosts(:second).interfaces.first
    property = interface.properties.build
    property.type = interface_property_types(:primary)
    property.value = 'true'
    property.save
    assert_kind_of Interface, hosts(:second).primary_interface
  end

  def test_external_interface
    assert_kind_of Interface, hosts(:first).external_interface
    assert_nil hosts(:second).external_interface
  end

  def test_average_point
    assert_nil hosts(:first).average_point
  end
end
