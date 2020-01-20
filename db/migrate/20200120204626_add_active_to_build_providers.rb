class AddActiveToBuildProviders < ActiveRecord::Migration[6.0]
  def change
    add_column :build_providers, :active, :boolean
  end
end
