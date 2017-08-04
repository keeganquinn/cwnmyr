class AddAddressesAndAllowNeighborsToInterfaceType < ActiveRecord::Migration[5.1]
  def change
    add_column :interface_types, :network_ipv4, :string
    add_column :interface_types, :network_ipv6, :string
    add_column :interface_types, :allow_neighbors, :boolean
  end
end
