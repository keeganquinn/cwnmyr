# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the DevicePropertyType model.
class DevicePropertyTypeDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    description: Field::Text,
    value_type: Field::Select.with_options(
      collection: DevicePropertyType.value_types.keys
    ),
    config: Field::Text,
    device_properties: Field::HasMany,
    device_property_options: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[code name value_type].freeze

  SHOW_PAGE_ATTRIBUTES = %i[code name description value_type config
                            device_properties device_property_options
                            created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[code name description value_type config
                       device_property_options].freeze

  # Display representation of the resource.
  def display_resource(device_property_type)
    device_property_type.name
  end
end
