require 'administrate/base_dashboard'

# Administrate Dashboard for the HostType model.
class HostTypeDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    body: Field::Text,
    hosts: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[code name].freeze

  SHOW_PAGE_ATTRIBUTES = %i[code name body hosts created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[code name body].freeze

  def display_resource(host_type)
    "Host Type ##{host_type.to_param}"
  end
end
