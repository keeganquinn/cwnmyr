# frozen_string_literal: true

# A DevicePropertyType describes a type of DeviceProperty available
# to select on a Device.
class DevicePropertyType < ApplicationRecord
  has_paper_trail

  has_many :device_properties
  has_many :device_property_options

  enum value_type: %i[number option config]

  validates_presence_of :code
  validates_presence_of :name
end
