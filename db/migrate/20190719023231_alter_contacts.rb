# frozen_string_literal: true

# Contact model updates.
class AlterContacts < ActiveRecord::Migration[5.2]
  def change
    change_column :contacts, :notes, :text

    remove_index :contacts, :code
    add_index :contacts, :code

    remove_index :contacts, :name
    add_index :contacts, :name
  end
end
