# Each HostProperty instance represents a property setting made in
# reference to a Host instance and a HostPropertyType instance.
class HostProperty < ApplicationRecord
  default_scope { order('host_id, key DESC') }

  belongs_to :host

  validates_presence_of :host_id
  validates_length_of :key, :minimum => 1
  validates_length_of :value, :minimum => 1

  def to_param
    [id, key].join('-')
  end
end
