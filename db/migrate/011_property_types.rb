#--
# $Id: 011_property_types.rb 509 2007-07-18 17:07:58Z keegan $
# Copyright 2006-2007 Keegan Quinn
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

class HostPropertyStub < ActiveRecord::Base
  set_table_name "host_properties"
  belongs_to(:type,
             :class_name => 'HostPropertyTypeStub',
             :foreign_key => 'host_property_type_id')
end

class HostPropertyTypeStub < ActiveRecord::Base
  set_table_name "host_property_types"
  has_many(:properties,
           :class_name => 'HostPropertyStub',
           :foreign_key => 'host_property_type_id')
end

class InterfacePropertyStub < ActiveRecord::Base
  set_table_name "interface_properties"
  belongs_to(:type,
             :class_name => 'InterfacePropertyTypeStub',
             :foreign_key => 'interface_property_type_id')
end

class InterfacePropertyTypeStub < ActiveRecord::Base
  set_table_name "interface_property_types"
  has_many(:properties,
           :class_name => 'InterfacePropertyStub',
           :foreign_key => 'interface_property_type_id')
end

class PropertyTypes < ActiveRecord::Migration
  def self.up
    create_table :host_property_types do |t|
      t.column :created_at,  :datetime
      t.column :updated_at,  :datetime
      t.column :code,        :string, :limit => 64, :null => false
      t.column :name,        :string, :limit => 255, :null => false
      t.column :description, :text
    end

    add_index(:host_property_types, :code, :unique => true)

    add_column(:host_properties, :host_property_type_id, :integer)

    HostPropertyStub.find(:all).each do |host_property|
      type = HostPropertyTypeStub.find_by_code(host_property.key)

      unless type
        type = HostPropertyTypeStub.new
        type.code = host_property.key
        type.name = host_property.key
        type.description = 'Imported'
        type.save
      end

      host_property.type = type
      host_property.save
    end

    remove_index(:host_properties, [ :host_id, :key ])
    remove_column(:host_properties, :key)


    create_table :interface_property_types do |t|
      t.column :created_at,  :datetime
      t.column :updated_at,  :datetime
      t.column :code,        :string, :limit => 64, :null => false
      t.column :name,        :string, :limit => 255, :null => false
      t.column :description, :text
    end

    add_index(:interface_property_types, :code, :unique => true)

    add_column(:interface_properties, :interface_property_type_id, :integer)

    InterfacePropertyStub.find(:all).each do |interface_property|
      type = InterfacePropertyTypeStub.find_by_code(interface_property.key)

      unless type
        type = InterfacePropertyTypeStub.new
        type.code = interface_property.key
        type.name = interface_property.key
        type.description = 'Imported'
        type.save
      end

      interface_property.type = type
      interface_property.save
    end

    remove_index(:interface_properties, [ :interface_id, :key ])
    remove_column(:interface_properties, :key)
  end

  def self.down
    add_column(:interface_properties, :key, :string, :limit => 64)

    InterfacePropertyStub.find(:all).each do |interface_property|
      interface_property.key = interface_property.type.code
      interface_property.save
    end

    remove_column(:interface_properties, :interface_property_type_id)

    remove_index(:interface_property_types, :code)

    drop_table(:interface_property_types)


    add_column(:host_properties, :key, :string, :limit => 64)

    HostPropertyStub.find(:all).each do |host_property|
      host_property.key = host_property.type.code
      host_property.save
    end

    remove_column(:host_properties, :host_property_type_id)

    remove_index(:host_property_types, :code)

    drop_table(:host_property_types)
  end
end
