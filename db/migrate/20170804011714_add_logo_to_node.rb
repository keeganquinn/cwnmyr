class AddLogoToNode < ActiveRecord::Migration[5.1]
  def change
    add_attachment :nodes, :logo
  end
end
