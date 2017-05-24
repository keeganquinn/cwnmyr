require "administrate/base_dashboard"

class HostDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    node: Field::BelongsTo,
    name: Field::String,
    body: Field::Text,
    interfaces: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :node,
    :name,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :node,
    :name,
    :body,
    :interfaces,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :node,
    :name,
    :body,
  ].freeze

  def display_resource(host)
    "Host ##{host.to_param}"
  end
end
