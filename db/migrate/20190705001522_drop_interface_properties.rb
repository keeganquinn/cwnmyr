class DropInterfaceProperties < ActiveRecord::Migration[5.2]
  def change
    drop_table :interface_properties
  end
end
