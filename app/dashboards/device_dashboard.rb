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
    image: Field::ActiveStorage,
    authorized_hosts: Field::HasMany,
    interfaces: Field::HasMany,
    device_builds: Field::HasMany,
    device_properties: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[node name device_type].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    node name device_type body image authorized_hosts interfaces
    device_builds device_properties created_at updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[node name device_type body image].freeze

  # Display representation of the resource.
  def display_resource(device)
    "Device ##{device.to_param}"
  end
end
