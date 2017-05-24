class CwnmyrCreateTables < ActiveRecord::Migration[5.0]
  def change
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

    create_table(:zones) do |t|
      t.string :code, limit: 64
      t.string :name
      t.text :body
      t.timestamps
    end

    add_index :zones, :code, unique: true
    add_index :zones, :name, unique: true

    create_table(:nodes) do |t|
      t.integer :zone_id
      t.string :code, limit: 64
      t.string :name
      t.text :body
      t.string :email
      t.timestamps
    end

    add_index :nodes, :code, unique: true
    add_index :nodes, :name, unique: true

    create_table(:hosts) do |t|
      t.integer :node_id
      t.string :name
      t.text :body
      t.timestamps
    end
  end
end
