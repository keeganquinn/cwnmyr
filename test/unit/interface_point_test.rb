#--
# $Id: interface_point_test.rb 2744 2006-06-10 23:19:28Z keegan $
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

class InterfacePointTest < ActiveSupport::TestCase
  fixtures :interfaces, :interface_points

  def setup
    @interface_point = InterfacePoint.new

    @interface_point.interface = interfaces(:second)
    @interface_point.latitude = 1.0
    @interface_point.longitude = 1.1
    @interface_point.height = 0.5
    @interface_point.error = 0.0
    @interface_point.description = 'Unit'
  end

  def test_create_read_update_delete
    assert(@interface_point.save)

    read_interface_point = interfaces(:second).points.find_by_description('Unit')

    assert_equal(@interface_point.error, read_interface_point.error)

    @interface_point.error = 2.0

    assert(@interface_point.save)

    assert(@interface_point.destroy)
  end

  def test_associations
    assert_kind_of(Interface, interface_points(:first).interface)
  end

  def test_validates_presence_of_interface_id
    @interface_point.interface = nil
    assert !@interface_point.save
  end

  def test_validates_numericality_of_latitude
    @interface_point.latitude = 'test'
    assert !@interface_point.save
  end

  def test_validates_numericality_of_longitude
    @interface_point.longitude = 'test'
    assert !@interface_point.save
  end

  def test_validates_numericality_of_height
    @interface_point.height = 'test'
    assert !@interface_point.save
  end

  def test_validates_numericality_of_error
    @interface_point.error = 'test'
    assert !@interface_point.save
  end

  def test_validates_presence_of_description
    @interface_point.description = nil
    assert !@interface_point.save
  end

  def test_validates_uniqueness_of_description
    @interface_point.description = 'First test'
    assert !@interface_point.save
  end
end
