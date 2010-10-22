#--
# $Id: node_comment_test.rb 2450 2006-03-29 03:30:18Z keegan $
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

class NodeCommentTest < ActiveSupport::TestCase
  fixtures :nodes, :node_comments, :users

  def setup
    @node_comment = NodeComment.new

    @node_comment.node = nodes(:first)
    @node_comment.user = users(:arthur)
    @node_comment.subject = 'Unit test'
    @node_comment.body = 'Just testing.'
    @node_comment.rating = 0
  end

  def test_create_read_update_delete
    assert(@node_comment.save)

    read_node_comment = nodes(:first).comments.find_by_subject 'Unit test'

    assert_equal(@node_comment.body, read_node_comment.body)

    @node_comment.body.reverse!

    assert(@node_comment.save)

    assert(@node_comment.destroy)
  end

  def test_associations
    assert_kind_of(Node, node_comments(:first).node)
    assert_kind_of(User, node_comments(:first).user)
  end

  def test_validates_presence_of_node_id
    @node_comment.node = nil
    assert !@node_comment.save
  end

  def test_validates_presence_of_user_id
    @node_comment.user = nil
    assert !@node_comment.save
  end

  def test_validates_length_of_subject
    @node_comment.subject = ''
    assert !@node_comment.save
  end

  def test_validates_length_of_body
    @node_comment.body = ''
    assert !@node_comment.save
  end

  def test_validates_rating
    @node_comment.rating = nil
    assert !@node_comment.save

    @node_comment.rating = 2
    assert !@node_comment.save
  end
end
