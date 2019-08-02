# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the BuildProvider model.
class BuildProviderDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    url: Field::String,
    server: Field::String,
    job: Field::String,
    device_builds: Field::HasMany,
    device_types: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[code name url].freeze

  SHOW_PAGE_ATTRIBUTES = %i[code name url server job device_builds device_types
                            created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[code name url server job].freeze

  def display_resource(build_provider)
    "Build Provider ##{build_provider.id}"
  end
end
