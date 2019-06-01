class RemoveUniqueConstraintFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :code
    remove_index :users, :name
    add_index :users, :code
    add_index :users, :name
  end
end
