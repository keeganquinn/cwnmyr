class CwnmyrCreateTables < ActiveRecord::Migration[5.0]
  def change
    create_table(:roles) do |t|
      t.string :code, :limit => 64
      t.string :name, :limit => 128
      t.text :content
      t.timestamps
    end

    create_table(:roles_users) do |t|
      t.integer :role_id
      t.integer :user_id
      t.timestamps
    end

    create_table(:zones) do |t|
      t.string :code, :limit => 64
      t.string :name, :limit => 128
      t.text :content
      t.boolean :expose
      t.timestamps
    end

    add_index :zones, :code, :unique => true
    add_index :zones, :name, :unique => true

    create_table(:zone_maintainers) do |t|
      t.integer :zone_id
      t.integer :user_id
      t.string :description, :limit => 128
    end

    create_table(:nodes) do |t|
      t.integer :zone_id
      t.string :code, :limit => 64
      t.string :name, :limit => 128
      t.text :content
      t.timestamps
    end

    add_index :nodes, :code, :unique => true
    add_index :nodes, :name, :unique => true

    create_table(:hosts) do |t|
      t.integer :node_id
      t.string :name, :limit => 64
      t.text :content
      t.timestamps
    end

    add_index :hosts, :name, :unique => true
  end
end
