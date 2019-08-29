class AddModeToBuildProviders < ActiveRecord::Migration[5.2]
  def change
    add_column :build_providers, :mode, :string
  end
end
