require "administrate/base_dashboard"

class InterfacePropertyDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    interface: Field::BelongsTo,
    key: Field::String,
    value: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :interface,
    :key,
    :value,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :interface,
    :key,
    :value,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :interface,
    :key,
    :value,
  ].freeze

  def display_resource(interface_property)
    "Interface Property ##{interface_property.to_param}"
  end
end
