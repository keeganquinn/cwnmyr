#--
# $Id: host_property_test.rb 2753 2006-06-16 08:57:06Z keegan $
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

class HostPropertyTest < ActiveSupport::TestCase
  fixtures :hosts, :host_properties, :host_property_types

  def setup
    @host_property = HostProperty.new

    @host_property.host = hosts(:first)
    @host_property.type = host_property_types(:another)
    @host_property.value = 'Unit Test'
  end

  def test_create_read_update_destroy
    assert(@host_property.save)

    read_host_property = hosts(:first).properties.find_by_host_property_type_id(host_property_types(:another).id)

    assert_equal(@host_property.value, read_host_property.value)

    @host_property.value.reverse!

    assert(@host_property.save)

    assert(@host_property.destroy)
  end

  def test_associations
    assert_kind_of(Host, host_properties(:first).host)
    assert_kind_of(HostPropertyType, host_properties(:first).type)
  end

  def test_validates_presence_of_host_id
    @host_property.host = nil
    assert !@host_property.save
  end

  def test_validates_presence_of_host_property_type_id
    @host_property.type = nil
    assert !@host_property.save
  end

  def test_validates_length_of_value
    @host_property.value = ''
    assert !@host_property.save
  end
end
