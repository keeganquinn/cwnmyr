#--
# $Id: user_test.rb 854 2009-10-24 02:07:39Z keegan $
# Copyright 2004-2007 Keegan Quinn
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

class UserTest < ActiveSupport::TestCase
  fixtures :users, :user_comments, :roles, :roles_users
  fixtures :zones, :zone_maintainers

  def test_associations
    assert_kind_of Array, users(:arthur).host_logs
    assert_kind_of Array, users(:arthur).host_type_comments
    assert_kind_of Array, users(:arthur).node_comments
    assert_kind_of Array, users(:arthur).node_logs
    assert_kind_of Array, users(:arthur).nodes
    assert_kind_of Array, users(:arthur).node_maintainers
    assert_kind_of Array, users(:arthur).roles
    assert_kind_of Array, users(:arthur).comments
    assert_kind_of Array, users(:arthur).comments_on_others
    assert_kind_of Array, users(:arthur).links
    assert_kind_of Array, users(:arthur).logs
    assert_kind_of Array, users(:arthur).zones
    assert_kind_of Array, users(:arthur).zone_maintainers
  end

  def test_create
    assert create_user.valid?
  end

  def test_validates_presence_of_login
    u = create_user(:login => nil)
    assert u.errors.on(:login)
  end

  def test_validates_presence_of_email
    u = create_user(:email => nil)
    assert u.errors.on(:email)
  end

  def test_validates_presence_of_password
    u = create_user(:password => nil)
    assert u.errors.on(:password)
  end

  def test_validates_presence_of_password_confirmation
    u = create_user(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_validates_length_of_password
    u = create_user(:password => 'abc', :password_confirmation => 'abc')
    assert u.errors.on(:password)
  end

  def test_validates_confirmation_of_password
    u = create_user(:password => 'abcdefg')
    assert u.errors.on(:password)
  end

  def test_validates_length_of_login
    u = create_user(:login => 'a')
    assert u.errors.on(:login)
  end

  def test_validates_length_of_email
    u = create_user(:email => "#{'a' * 100}@sniz.net")
    assert u.errors.on(:email)
  end

  def test_validates_uniqueness_of_login
    u = create_user(:login => 'quentin')
    assert u.errors.on(:login)
  end

  def test_validates_uniqueness_of_email
    u = create_user(:email => 'quentin@example.com')
    assert u.errors.on(:email)
  end

  def test_validates_format_of_login
    u = create_user(:login => 'ee*!@$')
    assert u.errors.on(:login)
  end

  def test_validates_as_email
    u = create_user(:email => 'snooty')
    assert u.errors.on(:email)
  end

  def test_password_change
    users(:quentin).update_attributes({
      :password => 'new password',
      :password_confirmation => 'new password'
    })
    assert_equal users(:quentin), User.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    users(:quentin).update_attributes(:login => 'quentin2')
    assert_equal users(:quentin), User.authenticate('quentin2', 'quentin')
  end

  def test_first_user_setup
    User.find(:all).each { |user| user.destroy }

    u = create_user
    assert_equal roles(:manage), u.roles.first
  end

  def test_find_by_param
    assert_equal users(:quentin), User.find_by_param('quentin')
  end

  def test_authenticate
    assert_equal users(:quentin), User.authenticate('quentin', 'quentin')
  end

  def test_encrypt
    assert_equal 40, users(:quentin).encrypt('sniz').size
  end

  def test_activate
    assert users(:arthur).activate

    assert users(:arthur).activated_at.acts_like?(:time)
    assert_nil users(:arthur).activation_code
  end

  def test_forgot_password
    assert users(:quentin).forgot_password
    assert_kind_of String, users(:quentin).activation_code
  end

  def test_recently_activated?
    assert !users(:quentin).recently_activated?

    assert users(:quentin).activate
    assert users(:quentin).recently_activated?
  end

  def test_recently_forgot?
    assert !users(:quentin).recently_forgot?

    assert users(:quentin).forgot_password
    assert users(:quentin).recently_forgot?
  end

  def test_has_role?
    assert !users(:quentin).has_role?('ManageConfig')
    assert users(:arthur).has_role?('ManageConfig')
  end

  def test_other_roles
    assert_equal 1, users(:quentin).other_roles.size
  end

  def test_to_param
    assert_equal 'quentin', users(:quentin).to_param
  end

  def test_fullname
    assert_nil users(:arthur).fullname
    assert_equal 'Doctor Tarantino', users(:quentin).fullname
  end

  def test_friends
    assert_kind_of Array, users(:quentin).friends
  end

  protected

  def create_user(options = {})
    User.create({
      :login => 'quire',
      :email => 'quire@example.com',
      :password => 'quire',
      :password_confirmation => 'quire'
    }.merge(options))
  end
end
