#--
# $Id: host_property_type_test.rb 854 2009-10-24 02:07:39Z keegan $
# Copyright 2006-2007 Keegan Quinn
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

class HostPropertyTypeTest < ActiveSupport::TestCase
  fixtures :hosts, :host_properties, :host_property_types

  def setup
    @host_property_type = HostPropertyType.new

    @host_property_type.code = 'unit_test'
    @host_property_type.name = 'Unit test'
  end

  def test_create_read_update_destroy
    assert(@host_property_type.save)

    read_host_property_type = HostPropertyType.find_by_code('unit_test')

    assert_equal(@host_property_type.name, read_host_property_type.name)

    @host_property_type.name.reverse!

    assert(@host_property_type.save)

    assert(@host_property_type.destroy)
  end

  def test_associations
    assert_kind_of(Array, host_property_types(:first).properties)
  end

  def test_validates_length_of_code
    @host_property_type.code = 'the-maximum-length-of-this-field-is-a-mere-' +
      'two-hundred-and-fifty-five-characters-since-it-is-supposed-' +
      'to-be-easy-to-type-and-remember-and-should-be-usable-in-' +
      'web-page-addresses-and-the-like'

    assert !@host_property_type.save
  end

  def test_validates_uniqueness_of_code
    @host_property_type.code = 'first_test'

    assert !@host_property_type.save
  end

  def test_validates_format_of_code
    @host_property_type.code = 'unit test'

    assert !@host_property_type.save
  end

  def test_validates_length_of_name
    @host_property_type.name = ''

    assert !@host_property_type.save
  end

  def test_find_by_param
    assert HostPropertyType.find_by_param(host_property_types(:first).to_param).valid?
  end

  def test_to_param
    assert_equal host_property_types(:first).code, host_property_types(:first).to_param
  end

  def test_stripped_name
    assert_equal('first-test', host_property_types(:first).stripped_name)
  end
end
