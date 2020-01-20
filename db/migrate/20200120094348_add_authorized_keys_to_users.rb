class AddAuthorizedKeysToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :authorized_keys, :text
  end
end
