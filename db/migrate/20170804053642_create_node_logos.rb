class CreateNodeLogos < ActiveRecord::Migration[5.1]
  def self.up
    create_table :logos do |t|
      t.integer    :node_id
      t.string     :style
      t.binary     :file_contents
      t.timestamps
    end
  end

  def self.down
    drop_table :logos
  end
end
