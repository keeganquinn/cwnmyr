# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the Zone model.
class ZoneDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    body: Field::Text,
    nav_logo: Field::ActiveStorage,
    nodes: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[code name].freeze

  SHOW_PAGE_ATTRIBUTES = %i[code name body nav_logo nodes
                            created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[code name body nav_logo].freeze

  def display_resource(zone)
    "Zone ##{zone.to_param}"
  end
end
