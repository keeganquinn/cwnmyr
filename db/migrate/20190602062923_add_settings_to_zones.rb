class AddSettingsToZones < ActiveRecord::Migration[5.2]
  def change
    add_column :zones, :title, :string
    add_column :zones, :default, :boolean
    add_column :zones, :address, :text
    add_column :zones, :latitude, :decimal
    add_column :zones, :longitude, :decimal
    add_column :zones, :zoom_default, :integer
    add_column :zones, :zoom_min, :integer
    add_column :zones, :zoom_max, :integer
  end
end
