#--
# $Id: 010_create_interface_properties.rb 2750 2006-06-11 12:35:31Z keegan $
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

class CreateInterfaceProperties < ActiveRecord::Migration
  def self.up
    create_table :interface_properties do |t|
      t.column :created_at,   :datetime
      t.column :updated_at,   :datetime
      t.column :interface_id, :integer, :null => false
      t.column :key,          :string,  :limit => 64, :null => false
      t.column :value,        :text,    :null => false
    end

    add_index(:interface_properties, [ :interface_id, :key ], :unique => true)
  end

  def self.down
    remove_index(:interface_properties, :interface_id)

    drop_table :interface_properties
  end
end
