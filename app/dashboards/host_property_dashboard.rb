require "administrate/base_dashboard"

class HostPropertyDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    host: Field::BelongsTo,
    key: Field::String,
    value: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :host,
    :key,
    :value,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :host,
    :key,
    :value,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :host,
    :key,
    :value,
  ].freeze

  def display_resource(host_property)
    "Host Property ##{host_property.to_param}"
  end
end
