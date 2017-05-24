require "administrate/base_dashboard"

class StatusDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    color: Field::String,
    nodes: Field::HasMany,
    hosts: Field::HasMany,
    interfaces: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :code,
    :name,
    :color
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :code,
    :name,
    :color,
    :nodes,
    :hosts,
    :interfaces,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :code,
    :name,
    :color,
  ].freeze

  def display_resource(status)
    "Status ##{status.to_param}"
  end
end
