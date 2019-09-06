# frozen_string_literal: true

# A DevicePropertyOption describes a selectable option available for
# a DevicePropertyType with value_type option.
class DevicePropertyOption < ApplicationRecord
  has_paper_trail

  belongs_to :device_property_type
  has_many :device_properties

  validates_presence_of :name
  validates_presence_of :value
end
