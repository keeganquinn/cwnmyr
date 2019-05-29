class AddOrdinalToStatuses < ActiveRecord::Migration[5.2]
  def change
    add_column :statuses, :ordinal, :boolean
  end
end
