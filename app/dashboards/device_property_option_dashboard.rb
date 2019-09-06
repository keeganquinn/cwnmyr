# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the DevicePropertyOption model.
class DevicePropertyOptionDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    device_property_type: Field::BelongsTo,
    name: Field::String,
    value: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[device_property_type name value].freeze

  SHOW_PAGE_ATTRIBUTES = %i[device_property_type name value
                            created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[device_property_type name value].freeze
end
