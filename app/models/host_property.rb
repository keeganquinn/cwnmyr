# Each HostProperty instance represents a property setting made in
# reference to a Host instance and a HostPropertyType instance.
class HostProperty < ApplicationRecord
  has_paper_trail
  belongs_to :host

  validates_length_of :key, minimum: 1
  validates_length_of :value, minimum: 1

  def to_param
    return unless id
    [id, key].join('-')
  end
end
