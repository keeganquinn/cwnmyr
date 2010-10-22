#--
# $Id: node_log_test.rb 2450 2006-03-29 03:30:18Z keegan $
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

class NodeLogTest < ActiveSupport::TestCase
  fixtures :nodes, :node_logs, :users

  def setup
    @node_log = NodeLog.new

    @node_log.node = nodes(:first)
    @node_log.user = users(:arthur)
    @node_log.subject = 'Unit test'
    @node_log.body = 'Just testing.'
  end

  def test_create_read_update_delete
    assert(@node_log.save)

    read_node_log = nodes(:first).logs.find_by_subject 'Unit test'

    assert_equal(@node_log.body, read_node_log.body)

    @node_log.body.reverse!

    assert(@node_log.save)

    assert(@node_log.destroy)
  end

  def test_associations
    assert_kind_of(Node, node_logs(:first).node)
    assert_kind_of(User, node_logs(:first).user)
  end

  def test_validates_presence_of_node_id
    @node_log.node = nil
    assert !@node_log.save
  end

  def test_validates_presence_of_user_id
    @node_log.user = nil
    assert !@node_log.save
  end

  def test_validates_length_of_subject
    @node_log.subject = ''
    assert !@node_log.save
  end

  def test_validates_length_of_body
    @node_log.body = ''
    assert !@node_log.save
  end
end
