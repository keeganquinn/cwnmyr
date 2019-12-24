class CreateAuthorizedHosts < ActiveRecord::Migration[6.0]
  def change
    create_table :authorized_hosts do |t|
      t.integer :device_id
      t.string :name
      t.string :address_mac
      t.string :address_ipv4
      t.string :address_ipv6
      t.text :comment
      t.timestamps
    end
  end
end
