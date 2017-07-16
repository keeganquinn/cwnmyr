# Migration to create application tables.
class CwnmyrCreateTables < ActiveRecord::Migration[5.0]
  def change
    create_table(:user_links) do |t|
      t.integer :user_id
      t.string :name
      t.string :url
      t.timestamps
    end

    add_index :user_links, :user_id
    add_index :user_links, :name

    create_table(:groups) do |t|
      t.string :code, limit: 64
      t.string :name
      t.text :body
      t.timestamps
    end

    add_index :groups, :code, unique: true
    add_index :groups, :name, unique: true

    create_table(:groups_users) do |t|
      t.integer :group_id
      t.integer :user_id
      t.timestamps
    end

    add_index :groups_users, :group_id
    add_index :groups_users, :user_id

    create_table(:zones) do |t|
      t.string :code, limit: 64
      t.string :name
      t.text :body
      t.timestamps
    end

    add_index :zones, :code, unique: true
    add_index :zones, :name, unique: true

    create_table(:statuses) do |t|
      t.string :code, limit: 64
      t.string :name
      t.string :color
      t.timestamps
    end

    add_index :statuses, :code, unique: true
    add_index :statuses, :name, unique: true

    create_table(:contacts) do |t|
      t.string :code, limit: 64
      t.string :name
      t.boolean :hidden
      t.string :email
      t.string :phone
      t.string :notes
    end

    add_index :contacts, :code, unique: true
    add_index :contacts, :name, unique: true
    add_index :contacts, :hidden

    create_table(:nodes) do |t|
      t.integer :zone_id
      t.string :code, limit: 64
      t.string :name
      t.integer :status_id
      t.text :body
      t.text :address
      t.decimal :latitude
      t.decimal :longitude
      t.string :hours
      t.text :notes
      t.integer :contact_id
      t.timestamps
    end

    add_index :nodes, :zone_id
    add_index :nodes, :code, unique: true
    add_index :nodes, :name, unique: true
    add_index :nodes, :status_id
    add_index :nodes, :contact_id

    create_table(:node_links) do |t|
      t.integer :node_id
      t.string :name
      t.string :url
      t.timestamps
    end

    add_index :node_links, :node_id
    add_index :node_links, :name

    create_table(:host_types) do |t|
      t.string :code, limit: 64
      t.string :name
      t.text :body
      t.timestamps
    end

    add_index :host_types, :code, unique: true
    add_index :host_types, :name, unique: true

    create_table(:hosts) do |t|
      t.integer :node_id
      t.string :name
      t.integer :host_type_id
      t.integer :status_id
      t.text :body
      t.timestamps
    end

    add_index :hosts, :node_id
    add_index :hosts, :name
    add_index :hosts, :host_type_id
    add_index :hosts, :status_id

    create_table(:host_properties) do |t|
      t.integer :host_id
      t.string :key
      t.string :value
      t.timestamps
    end

    add_index :host_properties, :host_id
    add_index :host_properties, :key

    create_table(:tags) do |t|
      t.string :code, limit: 64
      t.string :name
      t.timestamps
    end

    add_index :tags, :code, unique: true
    add_index :tags, :name, unique: true

    create_table(:nodes_tags) do |t|
      t.integer :node_id
      t.integer :tag_id
      t.timestamps
    end

    add_index :nodes_tags, :node_id
    add_index :nodes_tags, :tag_id

    create_table(:interface_types) do |t|
      t.string :code, limit: 64
      t.string :name
      t.text :body
      t.timestamps
    end

    add_index :interface_types, :code, unique: true
    add_index :interface_types, :name, unique: true

    create_table(:interfaces) do |t|
      t.integer :host_id
      t.string :code
      t.string :name
      t.integer :interface_type_id
      t.integer :status_id
      t.text :body
      t.string :address_ipv4
      t.string :address_ipv6
      t.string :address_mac
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :altitude
      t.string :essid
      t.string :security_psk
      t.string :channel
      t.decimal :tx_power
      t.decimal :rx_sensitivity
      t.decimal :cable_loss
      t.decimal :antenna_gain
      t.decimal :beamwidth_h
      t.decimal :beamwidth_v
      t.decimal :azimuth
      t.decimal :elevation
      t.string :polarity
      t.timestamps
    end

    add_index :interfaces, :host_id
    add_index :interfaces, :code
    add_index :interfaces, :name
    add_index :interfaces, :interface_type_id
    add_index :interfaces, :status_id

    create_table(:interface_properties) do |t|
      t.integer :interface_id
      t.string :key
      t.string :value
      t.timestamps
    end

    add_index :interface_properties, :interface_id
    add_index :interface_properties, :key
  end
end
