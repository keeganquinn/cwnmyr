#--
# $Id: 012_add_status_color.rb 510 2007-07-18 17:10:39Z keegan $
# Copyright 2007 Keegan Quinn
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

class StatusStub < ActiveRecord::Base
  set_table_name 'statuses'

  def color_rgbhex
    return '000000' unless display_red and display_green and display_blue

    (display_red > 15 ? '' : '0') + display_red.to_s(base = 16) +
        (display_green > 15 ? '' : '0') + display_green.to_s(base = 16) +
        (display_blue > 15 ? '' : '0') + display_blue.to_s(base = 16)
  end

  def color_red_i
    return 0 if color.blank? or color.size != 6

    color[0..1].to_i(base = 16)
  end

  def color_green_i
    return 0 if color.blank? or color.size != 6

    color[2..3].to_i(base = 16)
  end

  def color_blue_i
    return 0 if color.blank? or color.size != 6

    color[4..5].to_i(base = 16)
  end
end

class AddStatusColor < ActiveRecord::Migration
  def self.up
    add_column :statuses, :color, :string, :limit => 8

    StatusStub.find(:all).each do |status|
      status.update_attribute :color, status.color_rgbhex
    end

    remove_column :statuses, :display_red
    remove_column :statuses, :display_green
    remove_column :statuses, :display_blue
  end

  def self.down
    add_column :statuses, :display_red, :integer
    add_column :statuses, :display_green, :integer
    add_column :statuses, :display_blue, :integer

    StatusStub.find(:all).each do |status|
      status.display_red = status.color_red_i
      status.display_green = status.color_green_i
      status.display_blue = status.color_blue_i

      status.save false
    end

    remove_column :statuses, :color
  end
end
