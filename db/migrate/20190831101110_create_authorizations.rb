# frozen_string_literal: true

# Migration to create authorizations table.
class CreateAuthorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.timestamps
    end
  end
end
