# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the Status model.
class StatusDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    default_display: Field::Boolean,
    color: Field::String,
    ordinal: Field::Number,
    nodes: Field::HasMany,
    devices: Field::HasMany,
    interfaces: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[code name color ordinal].freeze

  SHOW_PAGE_ATTRIBUTES = %i[code name default_display color ordinal
                            nodes devices interfaces].freeze

  FORM_ATTRIBUTES = %i[code name default_display color ordinal].freeze

  def display_resource(status)
    "Status ##{status.to_param}"
  end
end
