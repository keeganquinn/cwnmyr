class AddUserAndGroupToContact < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :user_id, :integer
    add_column :contacts, :group_id, :integer
    add_index :contacts, :user_id
    add_index :contacts, :group_id
  end
end
