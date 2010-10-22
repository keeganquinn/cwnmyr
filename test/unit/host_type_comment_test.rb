#--
# $Id: host_type_comment_test.rb 2641 2006-05-20 06:39:19Z keegan $
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

class HostTypeCommentTest < ActiveSupport::TestCase
  fixtures :host_types, :host_type_comments, :users

  def setup
    @host_type_comment = HostTypeComment.new

    @host_type_comment.host_type = host_types(:first)
    @host_type_comment.user = users(:arthur)
    @host_type_comment.subject = 'Unit test'
    @host_type_comment.body = 'Just testing.'
    @host_type_comment.rating = 0
  end

  def test_create_read_update_delete
    assert(@host_type_comment.save)

    read_host_type_comment = host_types(:first).comments.find_by_subject 'Unit test'

    assert_equal(@host_type_comment.body, read_host_type_comment.body)

    @host_type_comment.body.reverse!

    assert(@host_type_comment.save)

    assert(@host_type_comment.destroy)
  end

  def test_associations
    assert_kind_of(HostType, host_type_comments(:first).host_type)
    assert_kind_of(User, host_type_comments(:first).user)
  end

  def test_validates_presence_of_host_type_id
    @host_type_comment.host_type = nil
    assert !@host_type_comment.save
  end

  def test_validates_presence_of_user_id
    @host_type_comment.user = nil
    assert !@host_type_comment.save
  end

  def test_validates_length_of_subject
    @host_type_comment.subject = ''
    assert !@host_type_comment.save
  end

  def test_validates_length_of_body
    @host_type_comment.body = ''
    assert !@host_type_comment.save
  end

  def test_validates_rating
    @host_type_comment.rating = nil
    assert !@host_type_comment.save

    @host_type_comment.rating = 2
    assert !@host_type_comment.save
  end
end
