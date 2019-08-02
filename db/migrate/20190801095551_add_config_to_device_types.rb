# frozen_string_literal: true

# Add config column to device_types table.
class AddConfigToDeviceTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :device_types, :config, :text
    add_column :device_types, :postbuild, :text
    add_column :device_types, :prebuild, :text
  end
end
