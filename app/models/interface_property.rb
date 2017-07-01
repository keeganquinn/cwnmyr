# Each InterfaceProperty instance represents a property setting made in
# reference to an Interface instance and an InterfacePropertyType instance.
class InterfaceProperty < ApplicationRecord
  belongs_to :interface

  validates_presence_of :interface_id
  validates_length_of :key, minimum: 1
  validates_length_of :value, minimum: 1
end
