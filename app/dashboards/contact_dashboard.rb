require "administrate/base_dashboard"

class ContactDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    hidden: Field::Boolean,
    email: Field::Email,
    phone: Field::String,
    notes: Field::Text,
    nodes: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :name,
    :hidden,
    :email,
    :phone,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :code,
    :name,
    :hidden,
    :email,
    :phone,
    :notes,
    :nodes,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :code,
    :name,
    :hidden,
    :email,
    :phone,
    :notes,
  ].freeze

  def display_resource(contact)
    "Contact ##{contact.to_param}"
  end
end
