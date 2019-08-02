# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the DeviceBuild model.
class DeviceBuildDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    build_provider: Field::BelongsTo,
    device: Field::BelongsTo,
    device_type: Field::BelongsTo,
    title: Field::String,
    body: Field::Text,
    url: Field::String,
    build_number: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES =
    %i[build_provider device_type device build_number].freeze

  SHOW_PAGE_ATTRIBUTES = %i[build_provider device_type device title body url
                            build_number created_at updated_at].freeze

  FORM_ATTRIBUTES =
    %i[build_provider device_type device title body url build_number].freeze

  def display_resource(device_build)
    device_build.title || "Build ##{device_build.build_number}"
  end
end
