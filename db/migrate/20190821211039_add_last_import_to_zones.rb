class AddLastImportToZones < ActiveRecord::Migration[5.2]
  def change
    add_column :zones, :last_import, :bigint

    zone = Zone.first
    zone.last_import = 1_563_497_498_201
    zone.save!
  end
end
