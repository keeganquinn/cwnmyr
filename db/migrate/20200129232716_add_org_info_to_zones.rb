class AddOrgInfoToZones < ActiveRecord::Migration[6.0]
  def change
    add_column :zones, :org_name, :string
    add_column :zones, :org_url, :string
    add_column :zones, :privacy_url, :string
    add_column :zones, :terms_url, :string
  end
end
