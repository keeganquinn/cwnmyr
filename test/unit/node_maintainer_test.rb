#--
# $Id: node_maintainer_test.rb 2450 2006-03-29 03:30:18Z keegan $
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

class NodeMaintainerTest < ActiveSupport::TestCase
  fixtures :nodes, :node_maintainers, :users

  def setup
    @node_maintainer = NodeMaintainer.new

    @node_maintainer.node = nodes(:first)
    @node_maintainer.maintainer = users(:arthur)
  end

  def test_create_read_update_delete
    assert(@node_maintainer.save)

    read_node_maintainer = nodes(:first).maintainers.find_by_user_id users(:arthur).id

    assert_equal(@node_maintainer.id, read_node_maintainer.id)

    @node_maintainer.description = 'Unit test'

    assert(@node_maintainer.save)

    assert(@node_maintainer.destroy)
  end

  def test_associations
    assert_kind_of(Node, node_maintainers(:first).node)
    assert_kind_of(User, node_maintainers(:first).maintainer)
  end

  def test_validates_presence_of_node_id
    @node_maintainer.node = nil
    assert !@node_maintainer.save
  end

  def test_validates_presence_of_user_id
    @node_maintainer.maintainer = nil
    assert !@node_maintainer.save
  end

  def test_display_name
    assert_equal users(:arthur).login, @node_maintainer.display_name

    @node_maintainer.description = 'Test'
    assert_equal users(:arthur).login + ' (Test)', @node_maintainer.display_name
  end
end
