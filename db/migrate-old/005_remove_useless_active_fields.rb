#--
# $Id: 005_remove_useless_active_fields.rb 2497 2006-04-06 09:50:08Z keegan $
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

class RemoveUselessActiveFields < ActiveRecord::Migration
  def self.up
    remove_column(:hosts, :active)
    remove_column(:interfaces, :active)
  end

  def self.down
    add_column(:interfaces, :active, :boolean)
    add_column(:hosts, :active, :boolean)
  end
end
