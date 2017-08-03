class RemoveStatusFromHostAndInterface < ActiveRecord::Migration[5.1]
  def change
    remove_column :hosts, :status_id, :integer
    remove_column :interfaces, :status_id, :integer
  end
end
