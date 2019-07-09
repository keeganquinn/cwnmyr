# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the Network model.
class NetworkDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    body: Field::Text,
    network_ipv4: Field::String,
    network_ipv6: Field::String,
    allow_neighbors: Field::Boolean,
    interfaces: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[code name].freeze

  SHOW_PAGE_ATTRIBUTES = %i[code name body interfaces network_ipv4 network_ipv6
                            allow_neighbors].freeze

  FORM_ATTRIBUTES = %i[code name body network_ipv4 network_ipv6
                       allow_neighbors].freeze

  def display_resource(network)
    "Network ##{network.to_param}"
  end
end
