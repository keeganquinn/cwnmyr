class RemoveOldTags < ActiveRecord::Migration[5.2]
  def change
    drop_table :tags
    drop_table :nodes_tags
  end
end
