# -*- coding: utf-8 -*-

#--
# Database migration class for core cwnmyr tables
# © 2015 Keegan Quinn
#++


# Database migration class for core cwnmyr tables.
class CwnmyrCreateTables < ActiveRecord::Migration
  def change
    create_table(:zones) do |t|
      t.string :code, :limit => 64
      t.string :name, :limit => 128
      t.text :content
      t.boolean :expose
      t.timestamps
    end

    add_index :zones, :code, :unique => true
    add_index :zones, :name, :unique => true

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
