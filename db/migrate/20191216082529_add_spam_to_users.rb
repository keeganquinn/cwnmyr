class AddSpamToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :spam, :boolean
  end
end
