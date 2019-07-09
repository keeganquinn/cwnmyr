# frozen_string_literal: true

# Various model updates.
class ModelUpdates < ActiveRecord::Migration[5.2]
  def change
    drop_table :node_links

    add_column :nodes, :website, :string
    add_column :nodes, :rss, :string
    add_column :nodes, :twitter, :string
    add_column :nodes, :wiki, :string

    rename_table :interface_types, :networks
    rename_column :interfaces, :interface_type_id, :network_id
  end
end
