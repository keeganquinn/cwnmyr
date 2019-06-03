class RemoveUnneededIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index :taggings, name: 'index_taggings_on_tag_id'
    remove_index :taggings, name: 'index_taggings_on_taggable_id'
    remove_index :taggings, name: 'index_taggings_on_tagger_id'
  end
end
