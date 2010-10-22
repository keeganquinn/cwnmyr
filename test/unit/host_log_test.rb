#--
# $Id: host_log_test.rb 2450 2006-03-29 03:30:18Z keegan $
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

class HostLogTest < ActiveSupport::TestCase
  fixtures :hosts, :host_logs, :users

  def setup
    @host_log = HostLog.new

    @host_log.host = hosts(:first)
    @host_log.user = users(:arthur)
    @host_log.subject = 'Unit test'
    @host_log.body = 'Testing, one two three.'
  end

  def test_create_read_update_destroy
    assert(@host_log.save)

    read_host_log = hosts(:first).logs.find_by_subject 'Unit test'

    assert_equal(@host_log.body, read_host_log.body)

    @host_log.body.reverse!

    assert(@host_log.save)

    assert(@host_log.destroy)
  end

  def test_associations
    assert_kind_of(Host, host_logs(:first).host)
    assert_kind_of(User, host_logs(:first).user)
  end

  def test_validates_presence_of_host_id
    @host_log.host = nil
    assert !@host_log.save
  end

  def test_validates_presence_of_user_id
    @host_log.user = nil
    assert !@host_log.save
  end

  def test_validates_length_of_subject
    @host_log.subject = ''
    assert !@host_log.save
  end

  def test_validates_length_of_body
    @host_log.body = ''
    assert !@host_log.save
  end
end
