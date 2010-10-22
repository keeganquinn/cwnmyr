#--
# $Id: 013_add_user_time_zone.rb 516 2007-07-18 18:31:59Z keegan $
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

class AddUserTimeZone < ActiveRecord::Migration
  def self.up
    add_column :users, :time_zone, :string,  :default => 'Etc/UTC'
  end

  def self.down
    remove_column :users, :time_zone
  end
end
