class AddDefaultDisplayToStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :statuses, :default_display, :boolean
  end
end
