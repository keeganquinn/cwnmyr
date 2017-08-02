class AddGroupToNode < ActiveRecord::Migration[5.1]
  def change
    add_column :nodes, :group_id, :integer
    add_index :nodes, :group_id
  end
end
