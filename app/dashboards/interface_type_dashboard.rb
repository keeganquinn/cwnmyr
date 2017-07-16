require 'administrate/base_dashboard'

# Administrate Dashboard for the InterfaceType model.
class InterfaceTypeDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    body: Field::Text,
    interfaces: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[code name].freeze

  SHOW_PAGE_ATTRIBUTES = %i[code name body interfaces].freeze

  FORM_ATTRIBUTES = %i[code name body].freeze

  def display_resource(interface_type)
    "Interface Type ##{interface_type.to_param}"
  end
end
