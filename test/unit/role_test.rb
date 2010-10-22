#--
# $Id: role_test.rb 854 2009-10-24 02:07:39Z keegan $
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

class RoleTest < ActiveSupport::TestCase
  fixtures :roles

  def setup
    @role = Role.new

    @role.code = 'unittest'
    @role.name = 'Unit test'
  end

  def test_create_read_update_delete
    assert(@role.save)

    read_role = Role.find_by_code 'unittest'

    assert_equal(@role.name, read_role.name)

    @role.name.reverse!

    assert(@role.save)

    assert(@role.destroy)
  end

  def test_associations
    assert_kind_of(Array, roles(:test).users)
  end

  def test_validates_length_of_code
    @role.code = 'the-maximum-length-of-this-field-is-a-mere-' +
      'two-hundred-and-fifty-five-characters-since-it-is-supposed-' +
      'to-be-easy-to-type-and-remember-and-should-be-usable-in-' +
      'web-page-addresses-and-the-like'
    assert !@role.save
  end

  def test_validates_uniqueness_of_code
    @role.code = 'fixture_test'
    assert !@role.save
  end

  def test_validates_format_of_code
    @role.code = 'unit test'
    assert !@role.save
  end

  def test_validates_length_of_name
    @role.name = ''
    assert !@role.save
  end

  def test_manager
    assert_equal 'ManageConfig', Role.manager
  end

  def test_find_by_param
    assert Role.find_by_param(roles(:manage).to_param).valid?
  end

  def test_to_param
    assert_equal roles(:manage).code, roles(:manage).to_param
  end

  def test_stripped_name
    assert_equal 'unit-test', @role.stripped_name
  end
end
