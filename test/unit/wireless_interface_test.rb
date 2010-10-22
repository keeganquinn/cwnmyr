#--
# $Id: wireless_interface_test.rb 2481 2006-04-03 21:30:01Z keegan $
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

class WirelessInterfaceTest < ActiveSupport::TestCase
  fixtures :interfaces, :wireless_interfaces

  def setup
    @wireless_interface = WirelessInterface.new

    @wireless_interface.interface = interfaces(:first)
    @wireless_interface.mode = 3
    @wireless_interface.essid = 'testing'
    @wireless_interface.channel = 11
    @wireless_interface.beamwidth_v = 36.0
    @wireless_interface.beamwidth_h = 360.0
    @wireless_interface.azimuth = 0.0
    @wireless_interface.elevation = 20.3
    @wireless_interface.tx_power = 15.0
    @wireless_interface.rx_sensitivity = -85.0
    @wireless_interface.cable_loss = 0.5
    @wireless_interface.antenna_gain = 5.0
  end

  def test_create_update_read_delete
    assert(@wireless_interface.save)

    read_wireless_interface = interfaces(:first).wireless_interface

    assert_equal(@wireless_interface.azimuth, read_wireless_interface.azimuth)

    @wireless_interface.elevation = 10.2

    assert(@wireless_interface.save)

    assert(@wireless_interface.destroy)
  end

  def test_associations
    assert_kind_of(Interface, wireless_interfaces(:second).interface)
  end

  def test_validates_presence_of_interface_id
    @wireless_interface.interface = nil
    assert !@wireless_interface.save
  end

  def test_validates_mode
    @wireless_interface.mode = -1
    assert !@wireless_interface.save
  end

  def test_validates_length_of_essid
    @wireless_interface.essid = 'onetwothreefourfivesixseveneightnineten'
    assert !@wireless_interface.save
  end

  def test_validates_channel
    @wireless_interface.channel = -1
    assert !@wireless_interface.save
  end

  def test_validates_error
    @wireless_interface.error = -1.0
    assert !@wireless_interface.save
  end

  def test_validates_beamwidth_v
    @wireless_interface.beamwidth_v = 543.2
    assert !@wireless_interface.save
  end

  def test_validates_beamwidth_h
    @wireless_interface.beamwidth_h = 543.2
    assert !@wireless_interface.save
  end

  def test_validates_azimuth
    @wireless_interface.azimuth = 432.1
    assert !@wireless_interface.save
  end

  def test_validates_numericality_of_elevation
    @wireless_interface.elevation = 'test'
    assert !@wireless_interface.save
  end

  def test_validates_tx_power
    @wireless_interface.tx_power = -1.0
    assert !@wireless_interface.save
  end

  def test_validates_rx_sensitivity
    @wireless_interface.rx_sensitivity = 1.0
    assert !@wireless_interface.save
  end

  def test_validates_cable_loss
    @wireless_interface.cable_loss = -0.1
    assert !@wireless_interface.save
  end

  def test_validates_antenna_gain
    @wireless_interface.antenna_gain = -0.1
    assert !@wireless_interface.save
  end

  def test_modes
    assert_kind_of Hash, WirelessInterface.modes
  end
end
