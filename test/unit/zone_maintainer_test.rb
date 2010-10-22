#--
# $Id: zone_maintainer_test.rb 2450 2006-03-29 03:30:18Z keegan $
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

class ZoneMaintainerTest < ActiveSupport::TestCase
  fixtures :users, :zones, :zone_maintainers

  def setup
    @zone_maintainer = ZoneMaintainer.new

    @zone_maintainer.zone = zones(:first)
    @zone_maintainer.maintainer = users(:arthur)
  end

  def test_create_read_update_delete
    assert(@zone_maintainer.save)

    read_zone_maintainer = zones(:first).maintainers.find_by_user_id users(:arthur).id

    assert_equal(@zone_maintainer.id, read_zone_maintainer.id)

    @zone_maintainer.description = 'Unit test'

    assert(@zone_maintainer.save)
    
    assert(@zone_maintainer.destroy)
  end

  def test_associations
    assert_kind_of(Zone, zone_maintainers(:first).zone)
    assert_kind_of(User, zone_maintainers(:first).maintainer)
  end

  def test_validates_presence_of_zone_id
    @zone_maintainer.zone = nil
    assert !@zone_maintainer.save
  end

  def test_validates_presence_of_user_id
    @zone_maintainer.maintainer = nil
    assert !@zone_maintainer.save
  end

  def test_display_name
    assert_equal users(:arthur).login, @zone_maintainer.display_name

    @zone_maintainer.description = 'Test'
    assert_equal users(:arthur).login + ' (Test)', @zone_maintainer.display_name
  end
end
