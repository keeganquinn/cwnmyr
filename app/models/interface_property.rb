# Each InterfaceProperty instance represents a property setting made in
# reference to an Interface instance and an InterfacePropertyType instance.
class InterfaceProperty < ApplicationRecord
  has_paper_trail
  belongs_to :interface

  validates_length_of :key, minimum: 1
  validates_length_of :value, minimum: 1

  def to_param
    return unless id
    [id, key].join('-')
  end
end
