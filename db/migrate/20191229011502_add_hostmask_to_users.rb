class AddHostmaskToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hostmask, :string
    add_column :users, :hostmask_confirmed_at, :datetime
    add_column :users, :unconfirmed_hostmask, :string
  end
end
