# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the DeviceProperty model.
class DevicePropertyDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    device: Field::BelongsTo,
    device_property_type: Field::BelongsTo,
    device_property_option: Field::BelongsTo,
    value: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[device device_property_type
                             device_property_option value].freeze

  SHOW_PAGE_ATTRIBUTES =
    %i[device device_property_type device_property_option value
       created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[device device_property_type device_property_option
                       value].freeze

  def display_resource(device_property)
    "Device Property ##{device_property.to_param}"
  end
end
