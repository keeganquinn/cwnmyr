class AddLastEventImportToZones < ActiveRecord::Migration[6.0]
  def change
    add_column :zones, :last_event_import, :bigint

    zone = Zone.first
    zone.last_event_import = 0
    zone.save!
  end
end
