require 'administrate/base_dashboard'

# Administrate Dashboard for the Host model.
class HostDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    node: Field::BelongsTo,
    name: Field::String,
    host_type: Field::BelongsTo,
    body: Field::Text,
    interfaces: Field::HasMany,
    host_properties: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[node name host_type].freeze

  SHOW_PAGE_ATTRIBUTES = %i[node name host_type body interfaces
                            host_properties created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[node name host_type body].freeze

  def display_resource(host)
    "Host ##{host.to_param}"
  end
end
