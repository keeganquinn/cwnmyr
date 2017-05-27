require "administrate/base_dashboard"

class NodeDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    zone: Field::BelongsTo,
    code: Field::String,
    name: Field::String,
    status: Field::BelongsTo,
    body: Field::Text,
    address: Field::Text,
    latitude: Field::Number,
    longitude: Field::Number,
    hours: Field::String,
    notes: Field::Text,
    contact: Field::BelongsTo,
    hosts: Field::HasMany,
    node_links: Field::HasMany,
    tags: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :zone,
    :code,
    :name,
    :status,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :zone,
    :code,
    :name,
    :status,
    :body,
    :address,
    :latitude,
    :longitude,
    :hours,
    :notes,
    :contact,
    :hosts,
    :node_links,
    :tags,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :zone,
    :code,
    :name,
    :status,
    :body,
    :address,
    :latitude,
    :longitude,
    :hours,
    :notes,
    :contact,
    :tags,
  ].freeze

  def display_resource(node)
    "Node ##{node.to_param}"
  end
end