require "administrate/base_dashboard"

class NodeLinkDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    node: Field::BelongsTo,
    name: Field::String,
    url: Field::String,
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
    :url,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :node,
    :name,
    :url,
  ].freeze

  def display_resource(node_link)
    "NodeLink ##{node_link.to_param}"
  end
end
