# frozen_string_literal: true

# Rename Host to Device.
class RenameHostToDevice < ActiveRecord::Migration[5.2]
  def change
    remove_index :host_properties, :host_id
    remove_index :host_properties, :key
    remove_index :host_types, :code
    remove_index :host_types, :name
    remove_index :hosts, :host_type_id
    remove_index :hosts, :name
    remove_index :hosts, :node_id
    remove_index :interfaces, :host_id

    rename_table :hosts, :devices
    rename_table :host_properties, :device_properties
    rename_table :host_types, :device_types

    rename_column :device_properties, :host_id, :device_id
    rename_column :devices, :host_type_id, :device_type_id
    rename_column :interfaces, :host_id, :device_id

    add_index :device_properties, :device_id
    add_index :device_properties, :key
    add_index :device_types, :code
    add_index :device_types, :name
    add_index :devices, :device_type_id
    add_index :devices, :name
    add_index :devices, :node_id
    add_index :interfaces, :device_id
  end
end
