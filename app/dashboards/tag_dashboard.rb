# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the Tag model.
class TagDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    nodes: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[code name].freeze

  SHOW_PAGE_ATTRIBUTES = %i[code name nodes created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[code name].freeze

  def display_resource(tag)
    "Tag ##{tag.to_param}"
  end
end
