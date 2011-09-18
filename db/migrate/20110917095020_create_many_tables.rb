#--
# Database migration class for core cwnmyr tables
# © 2011 Keegan Quinn
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

# Database migration class for core cwnmyr tables.
class CreateManyTables < ActiveRecord::Migration
  def change
    create_table(:zones) do |t|
      t.string :code, :limit => 64
      t.string :name, :limit => 128
      t.text :content
      t.timestamps
    end

    add_index :zones, :code, :unique => true
    add_index :zones, :name, :unique => true

    create_table(:nodes) do |t|
      t.integer :zone_id
      t.string :code, :limit => 64
      t.string :name, :limit => 128
      t.text :content
      t.timestamps
    end

    add_index :nodes, :code, :unique => true
    add_index :nodes, :name, :unique => true

    create_table(:hosts) do |t|
      t.integer :node_id
      t.string :name, :limit => 64
      t.text :content
      t.timestamps
    end

    add_index :hosts, :name, :unique => true
  end
end
