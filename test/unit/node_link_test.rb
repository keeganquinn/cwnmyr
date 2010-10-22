#--
# $Id: node_link_test.rb 2483 2006-04-03 22:38:04Z keegan $
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

class NodeLinkTest < ActiveSupport::TestCase
  fixtures :nodes, :node_links

  def setup
    @node_link = NodeLink.new

    @node_link.node = nodes(:first)
    @node_link.name = 'Unit test'
    @node_link.application = 'test'
    @node_link.data = 'http://testing'
  end

  def test_create_read_update_delete
    assert(@node_link.save)

    read_node_link = nodes(:first).links.find_by_name 'Unit test'

    assert_equal(@node_link.data, read_node_link.data)

    @node_link.application.reverse!

    assert(@node_link.save)

    assert(@node_link.destroy)
  end

  def test_associations
    assert_kind_of(Node, node_links(:first).node)
  end

  def test_validates_presence_of_node_id
    @node_link.node = nil
    assert !@node_link.save
  end

  def test_validates_length_of_name
    @node_link.name = ''
    assert !@node_link.save
  end

  def test_validates_length_of_application
    @node_link.application = ''
    assert !@node_link.save
  end

  def test_validates_format_of_application
    @node_link.application = 'glarble goot'
    assert !@node_link.save
  end

  def test_validates_length_of_data
    @node_link.data = ''
    assert !@node_link.save
  end

  def test_validates_format_of_data
    @node_link.data = 'just testing'
    assert !@node_link.save
  end
end
