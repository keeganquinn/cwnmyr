#--
# $Id: 008_remove_roles_users_id_column.rb 2725 2006-06-07 09:45:12Z keegan $
# Copyright 2006 Keegan Quinn
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

class RemoveRolesUsersIdColumn < ActiveRecord::Migration
  def self.up
    remove_column(:roles_users, :id)
  end

  def self.down
    add_column(:roles_users, :id, :integer)
  end
end
