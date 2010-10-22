#--
# $Id: user_log_test.rb 2450 2006-03-29 03:30:18Z keegan $
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

class UserLogTest < ActiveSupport::TestCase
  fixtures :users, :user_logs

  def setup
    @user_log = UserLog.new

    @user_log.user = users(:arthur)
    @user_log.subject = 'Unit test'
    @user_log.body = 'Just testing.'
  end

  def test_create_read_update_delete
    assert(@user_log.save)

    read_user_log = users(:arthur).logs.find_by_subject 'Unit test'

    assert_equal(@user_log.body, read_user_log.body)

    @user_log.body.reverse!

    assert(@user_log.save)

    assert(@user_log.destroy)
  end

  def test_associations
    assert_kind_of(User, user_logs(:first).user)
  end

  def test_validates_presence_of_user_id
    @user_log.user = nil
    assert !@user_log.save
  end

  def test_validates_length_of_subject
    @user_log.subject = ''
    assert !@user_log.save
  end

  def test_validates_length_of_body
    @user_log.body = ''
    assert !@user_log.save
  end
end
