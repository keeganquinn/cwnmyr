#--
# $Id: 001_add_authenticated_table.rb 2454 2006-03-29 04:19:02Z keegan $
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

class AddAuthenticatedTable < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.column :created_at,       :datetime
      t.column :updated_at,       :datetime
      t.column :login,            :string, :limit => 40
      t.column :email,            :string, :limit => 100
      t.column :crypted_password, :string, :limit => 40
      t.column :salt,             :string, :limit => 40
      t.column :activation_code,  :string, :limit => 40
      t.column :activated_at,     :datetime
      t.column :displayname,      :string, :limit => 64
      t.column :firstname,        :string, :limit => 64
      t.column :lastname,         :string, :limit => 64
    end

    add_index(:users, :login, :unique => true)
    add_index(:users, :email, :unique => true)
  end

  def self.down
    remove_index(:users, :email)
    remove_index(:users, :login)

    drop_table(:users)
  end
end
