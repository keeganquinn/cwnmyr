class AddUserToNode < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :user_id, :integer
  end
end
