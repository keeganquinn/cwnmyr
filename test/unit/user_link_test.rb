#--
# $Id: user_link_test.rb 2483 2006-04-03 22:38:04Z keegan $
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

class UserLinkTest < ActiveSupport::TestCase
  fixtures :users, :user_links

  def setup
    @user_link = UserLink.new

    @user_link.user = users(:arthur)
    @user_link.name = 'Unit test'
    @user_link.application = 'test'
    @user_link.data = 'http://testing'
  end

  def test_create_read_update_delete
    assert(@user_link.save)

    read_user_link = users(:arthur).links.find_by_name 'Unit test'

    assert_equal(@user_link.data, read_user_link.data)

    @user_link.application.reverse!

    assert(@user_link.save)

    assert(@user_link.destroy)
  end

  def test_associations
    assert_kind_of(User, user_links(:first).user)
  end

  def test_validates_presence_of_user_id
    @user_link.user = nil
    assert !@user_link.save
  end

  def test_validates_length_of_name
    @user_link.name = ''
    assert !@user_link.save
  end

  def test_validates_length_of_application
    @user_link.application = ''
    assert !@user_link.save
  end

  def test_validates_format_of_application
    @user_link.application = 'unit test'
    assert !@user_link.save
  end

  def test_validates_length_of_data
    @user_link.data = ''
    assert !@user_link.save
  end

  def test_validates_format_of_data
    @user_link.data = 'just testing'
    assert !@user_link.save
  end
end
