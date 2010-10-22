#--
# $Id: host_service_test.rb 2450 2006-03-29 03:30:18Z keegan $
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

class HostServiceTest < ActiveSupport::TestCase
  fixtures :hosts, :host_services, :services

  def setup
    @host_service = HostService.new

    @host_service.host = hosts(:first)
    @host_service.service = services(:second)
  end

  def test_create_read_update_destroy
    assert(@host_service.save)

    read_host_service = hosts(:first).services.find_by_service_id services(:second).id

    assert_equal(@host_service.id, read_host_service.id)

    @host_service.service = services(:another)

    assert(@host_service.save)

    assert(@host_service.destroy)
  end

  def test_associations
    assert_kind_of(Host, host_services(:first).host)
    assert_kind_of(Service, host_services(:first).service)
  end

  def test_validates_presence_of_host_id
    @host_service.host = nil
    assert !@host_service.save
  end

  def test_validates_presence_of_service_id
    @host_service.service = nil
    assert !@host_service.save
  end
end
