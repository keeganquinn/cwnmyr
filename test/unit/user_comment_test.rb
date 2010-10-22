#--
# $Id: user_comment_test.rb 2450 2006-03-29 03:30:18Z keegan $
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

class UserCommentTest < ActiveSupport::TestCase
  fixtures :users, :user_comments

  def setup
    @user_comment = UserComment.new

    @user_comment.user = users(:arthur)
    @user_comment.commenting_user = users(:quentin)
    @user_comment.subject = 'Unit test'
    @user_comment.body = 'Just testing.'
    @user_comment.rating = 0
  end

  def test_create_read_update_delete
    assert(@user_comment.save)

    read_user_comment = users(:arthur).comments.find_by_subject 'Unit test'

    assert_equal(@user_comment.body, read_user_comment.body)
    
    @user_comment.body.reverse!

    assert(@user_comment.save)

    assert(@user_comment.destroy)
  end

  def test_associations
    assert_kind_of(User, user_comments(:first).user)
    assert_kind_of(User, user_comments(:first).commenting_user)
  end

  def test_validates_presence_of_commenting_user_id
    @user_comment.commenting_user = nil
    assert !@user_comment.save
  end

  def test_validates_presence_of_user_id
    @user_comment.user = nil
    assert !@user_comment.save
  end

  def test_validates_length_of_subject
    @user_comment.subject = ''
    assert !@user_comment.save
  end

  def test_validates_length_of_body
    @user_comment.body = ''
    assert !@user_comment.save
  end

  def test_validates_rating
    @user_comment.rating = nil
    assert !@user_comment.save

    @user_comment.rating = 2
    assert !@user_comment.save
  end
end
