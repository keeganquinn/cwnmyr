#--
# $Id: node_test.rb 2745 2006-06-10 23:21:05Z keegan $
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

class NodeTest < ActiveSupport::TestCase
  fixtures :hosts, :nodes, :statuses, :users, :zones
  fixtures :interfaces, :interface_points

  def setup
    @node = Node.new

    @node.user = users(:arthur)
    @node.status = statuses(:first)
    @node.zone = zones(:first)
    @node.code = 'unittest'
    @node.name = 'Unit test'
  end

  def test_create_read_update_delete
    assert(@node.save)

    read_node = Node.find_by_code 'unittest'

    assert_equal(@node.name, read_node.name)

    @node.name.reverse!

    assert(@node.save)

    assert(@node.destroy)
  end

  def test_associations
    assert_kind_of(User, nodes(:first).user)
    assert_kind_of(Status, nodes(:first).status)
    assert_kind_of(Zone, nodes(:first).zone)
  end

  def test_validates_presence_of_user_id
    @node.user = nil
    assert !@node.save
  end

  def test_validates_presence_of_status_id
    @node.status = nil
    assert !@node.save
  end

  def test_validates_presence_of_zone_id
    @node.zone = nil
    assert !@node.save
  end

  def test_validates_length_of_code
    @node.code = 'the-maximum-length-of-this-field-is-a-mere-' +
      'two-hundred-and-fifty-five-characters-since-it-is-supposed-' +
      'to-be-easy-to-type-and-remember-and-should-be-usable-in-' +
      'web-page-addresses-and-the-like'
    assert !@node.save
  end

  def test_validates_uniqueness_of_code
    @node.code = 'first_test'
    assert !@node.save
  end

  def test_validates_format_of_code
    @node.code = 'unit test'
    assert !@node.save
  end

  def test_validates_length_of_name
    @node.name = ''
    assert !@node.save
  end

  def test_validates_uniqueness_of_name
    @node.name = 'First test'
    assert !@node.save
  end

  def test_stripped_name
    assert_equal 'unit-test', @node.stripped_name
  end

  def test_graph
    assert_kind_of RGL::AdjacencyGraph, nodes(:first).graph
  end

  def test_primary_host
    assert_kind_of Host, nodes(:first).primary_host
    assert_nil nodes(:second).primary_host
  end

  def test_average_point
    assert_nil nodes(:first).average_point
    assert_kind_of Hash, nodes(:second).average_point
  end
end
