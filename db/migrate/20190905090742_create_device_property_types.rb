# frozen_string_literal: true

# Create device_property_types tables.
class CreateDevicePropertyTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :device_property_types do |t|
      t.string :code
      t.string :name
      t.text :description
      t.integer :value_type
      t.text :config
      t.timestamps
    end

    create_table :device_property_options do |t|
      t.integer :device_property_type_id
      t.string :name
      t.string :value
      t.timestamps
    end

    add_column :device_properties, :device_property_type_id, :integer
    add_column :device_properties, :device_property_option_id, :integer

    DeviceProperty.all.each do |device_property|
      device_property_type =
        DevicePropertyType.find_or_initialize_by code: device_property.key
      device_property_type.name ||= device_property.key
      device_property_type.save!

      device_property.device_property_type = device_property_type
      device_property.save!
    end

    remove_column :device_properties, :key
  end
end
