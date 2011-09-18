#--
# $Id: 004_add_wireless_interface_radio_fields.rb 2481 2006-04-03 21:30:01Z keegan $
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

class AddWirelessInterfaceRadioFields < ActiveRecord::Migration
  def self.up
    remove_column(:wireless_interfaces, :eirp)
    add_column(:wireless_interfaces, :tx_power, :float)
    add_column(:wireless_interfaces, :rx_sensitivity, :float)
    add_column(:wireless_interfaces, :cable_loss, :float)
    add_column(:wireless_interfaces, :antenna_gain, :float)
  end

  def self.down
    remove_column(:wireless_interfaces, :antenna_gain)
    remove_column(:wireless_interfaces, :cable_loss)
    remove_column(:wireless_interfaces, :rx_sensitivity)
    remove_column(:wireless_interfaces, :tx_power)
    add_column(:wireless_interfaces, :eirp, :float)
  end
end
