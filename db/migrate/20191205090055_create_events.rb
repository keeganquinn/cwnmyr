class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :name
      t.text :description
      t.string :action_url
      t.boolean :action_priority
      t.string :action_text
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :splash_position
      t.boolean :published
      t.timestamps
    end
  end
end
