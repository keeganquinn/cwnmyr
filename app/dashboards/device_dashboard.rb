# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the Device model.
class DeviceDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    node: Field::BelongsTo,
    name: Field::String,
    device_type: Field::BelongsTo,
    body: Field::Text,
    interfaces: Field::HasMany,
    device_properties: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[node name device_type].freeze

  SHOW_PAGE_ATTRIBUTES = %i[node name device_type body interfaces
                            device_properties created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[node name device_type body].freeze

  def display_resource(device)
    "Device ##{device.to_param}"
  end
end
