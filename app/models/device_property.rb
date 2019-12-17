# frozen_string_literal: true

# Each DeviceProperty instance represents a property value
# associated with a Device.
class DeviceProperty < ApplicationRecord
  has_paper_trail
  belongs_to :device
  belongs_to :device_property_type
  belongs_to :device_property_option, optional: true

  # Join clause to load associated DevicePropertyTypes with config values.
  def self.with_config
    joins(:device_property_type).where(
      device_property_types: { value_type: :config }
    )
  end

  # Join clause to load associated DevicePropertyTypes with non-config values.
  def self.with_values
    joins(:device_property_type).where.not(
      device_property_types: { value_type: :config }
    )
  end

  # Display representation of the property value.
  def display_value
    device_property_type&.config? ? I18n.t(:enabled) : value
  end

  # Canonical identifier.
  def to_param
    return unless id

    [id, device_property_type&.code].join('-')
  end
end
