#--
# $Id: wireless_interface.rb 361 2007-05-16 00:52:06Z keegan $
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

# This model represents wireless-specific properties which pertain to an
# instance of Interface.
class WirelessInterface < ActiveRecord::Base
  default_scope :order => 'interface_id DESC'

  belongs_to :interface

  validates_presence_of :interface_id
  validates_each :mode do |record, attr, value|
    if value
      record.errors.add attr, 'is out of range' if value < 0 or value > 10
    end
  end
  validates_length_of :essid, :maximum => 32
  validates_each :channel do |record, attr, value|
    if value
      record.errors.add attr, 'is out of range' if value <= 0 or value > 255
    end
  end
  validates_each :beamwidth_v, :beamwidth_h, :azimuth do |record, attr, value|
    if value
      record.errors.add attr, 'is out of range' if value < 0 or value > 360
    end
  end
  validates_numericality_of :elevation,
    :if => Proc.new { |o| not o.elevation.nil? }
  validates_each :tx_power, :cable_loss, :antenna_gain, :error do |record, attr, value|
    if value
      record.errors.add attr, 'is out of range' if value < 0
    end
  end
  validates_each :rx_sensitivity do |record, attr, value|
    if value
      record.errors.add attr, 'is out of range' if value > 0
    end
  end

  # This method returns a Hash which enumerates possible values for the
  # +mode+ attribute with labels.
  def self.modes
    return {
      'Automatic' => 0,
      'Ad-hoc station' => 1,
      'Infrastructure station' => 2,
      'Infrastructure master' => 3,
      'Primary repeater' => 4,
      'Secondary repeater' => 5,
      'Monitor' => 6
    }
  end
end
