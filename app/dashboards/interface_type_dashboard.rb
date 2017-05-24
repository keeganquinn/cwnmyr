require "administrate/base_dashboard"

class InterfaceTypeDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    body: Field::Text,
    interfaces: Field::HasMany,
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
    :interfaces,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :code,
    :name,
    :body,
  ].freeze

  def display_resource(interface_type)
    "Interface Type ##{interface_type.to_param}"
  end
end
