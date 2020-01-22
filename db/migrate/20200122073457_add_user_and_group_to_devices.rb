class AddUserAndGroupToDevices < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :user_id, :integer
    add_column :devices, :group_id, :integer
  end
end
