#--
# $Id: status_test.rb 854 2009-10-24 02:07:39Z keegan $
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

class StatusTest < ActiveSupport::TestCase
  fixtures :statuses

  def setup
    @status = Status.new

    @status.code = 'unittest'
    @status.name = 'Unit test'
  end

  def test_create_read_update_delete
    assert(@status.save)

    read_status = Status.find_by_code 'unittest'

    assert_equal(@status.name, read_status.name)

    @status.name.reverse!

    assert(@status.save)

    assert(@status.destroy)
  end

  def test_associations
    assert_kind_of Array, statuses(:first).nodes
    assert_kind_of Array, statuses(:first).hosts
    assert_kind_of Array, statuses(:first).interfaces
  end

  def test_validates_length_of_code
    @status.code = 'the-maximum-length-of-this-field-is-a-mere-' +
      'two-hundred-and-fifty-five-characters-since-it-is-supposed-' +
      'to-be-easy-to-type-and-remember-and-should-be-usable-in-' +
      'web-page-addresses-and-the-like'
    assert !@status.save
  end

  def test_validates_uniqueness_of_code
    @status.code = 'first_test'
    assert !@status.save
  end

  def test_validates_format_of_code
    @status.code = 'unit test'
    assert !@status.save
  end

  def test_validates_length_of_name
    @status.name = ''
    assert !@status.save
  end

  def test_find_by_param
    assert Status.find_by_param(statuses(:first).to_param).valid?
  end

  def test_to_param
    assert_equal statuses(:first).code, statuses(:first).to_param
  end

  def test_stripped_name
    assert_equal 'unit-test', @status.stripped_name
  end
end
