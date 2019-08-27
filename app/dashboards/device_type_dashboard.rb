# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the DeviceType model.
class DeviceTypeDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    body: Field::Text,
    build_provider: Field::BelongsTo,
    config: Field::Text,
    devices: Field::HasMany,
    device_builds: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[code name build_provider].freeze

  SHOW_PAGE_ATTRIBUTES = %i[code name body build_provider config
                            devices device_builds created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[code name body build_provider config].freeze

  def display_resource(device_type)
    "Device Type ##{device_type.to_param}"
  end
end
