#--
# $Id: interface_property_test.rb 2753 2006-06-16 08:57:06Z keegan $
# Copyright 2006 Keegan Quinn
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

class InterfacePropertyTest < ActiveSupport::TestCase
  fixtures :interfaces, :interface_properties, :interface_property_types

  def setup
    @interface_property = InterfaceProperty.new

    @interface_property.interface = interfaces(:first)
    @interface_property.type = interface_property_types(:another)
    @interface_property.value = 'Unit Test'
  end

  def test_create_read_update_destroy
    assert(@interface_property.save)

    read_interface_property = interfaces(:first).properties.find_by_interface_property_type_id(interface_property_types(:another).id)

    assert_equal(@interface_property.value, read_interface_property.value)

    @interface_property.value.reverse!

    assert(@interface_property.save)

    assert(@interface_property.destroy)
  end

  def test_associations
    assert_kind_of(Interface, interface_properties(:first).interface)
  end

  def test_validates_presence_of_interface_id
    @interface_property.interface = nil
    assert !@interface_property.save
  end

  def test_validates_presence_of_interface_property_type_id
    @interface_property.type = nil
    assert !@interface_property.save
  end

  def test_validates_length_of_value
    @interface_property.value = ''
    assert !@interface_property.save
  end
end
