# frozen_string_literal: true

# Create build_providers and device_builds tables.
class CreateBuildProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :build_providers do |t|
      t.string :name
      t.string :url
      t.timestamps
    end

    create_table :device_builds do |t|
      t.integer :build_provider_id
      t.integer :device_id
      t.integer :device_type_id
      t.string :title
      t.string :body
      t.string :url
      t.timestamps
    end

    add_column :device_types, :build_provider_id, :integer
    add_column :nodes, :live_date, :date
  end
end
