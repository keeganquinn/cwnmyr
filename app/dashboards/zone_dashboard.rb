require "administrate/base_dashboard"

class ZoneDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    body: Field::Text,
    nodes: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :code,
    :name,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :code,
    :name,
    :body,
    :nodes,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :code,
    :name,
    :body,
  ].freeze

  def display_resource(zone)
    "Zone ##{zone.to_param}"
  end
end
