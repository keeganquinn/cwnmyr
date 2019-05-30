# frozen_string_literal: true

# Each DeviceProperty instance represents a property value
# associated with a Device.
class DeviceProperty < ApplicationRecord
  has_paper_trail
  belongs_to :device

  validates_length_of :key, minimum: 1
  validates_length_of :value, minimum: 1

  def to_param
    return unless id

    [id, key].join('-')
  end
end
