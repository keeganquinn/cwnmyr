# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the Node model.
class NodeDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    zone: Field::BelongsTo,
    code: Field::String,
    name: Field::String,
    user: Field::BelongsTo,
    group: Field::BelongsTo,
    status: Field::BelongsTo,
    logo: Field::ActiveStorage,
    body: Field::Text,
    address: Field::Text,
    latitude: Field::Number,
    longitude: Field::Number,
    hours: Field::String,
    notes: Field::Text,
    live_date: Field::DateTime,
    website: Field::String,
    rss: Field::String,
    twitter: Field::String,
    wiki: Field::String,
    contact: Field::BelongsTo,
    devices: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[zone code name user status].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    zone code name user group status logo body address latitude longitude hours
    notes live_date website rss twitter wiki contact devices
    created_at updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    zone code name user group status logo body address hours notes live_date
    website rss twitter wiki contact
  ].freeze

  # Display representation of the resource.
  def display_resource(node)
    "Node#{node.code} (#{node.id})"
  end
end
