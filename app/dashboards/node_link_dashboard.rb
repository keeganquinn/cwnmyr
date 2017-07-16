require 'administrate/base_dashboard'

# Administrate Dashboard for the NodeLink model.
class NodeLinkDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    node: Field::BelongsTo,
    name: Field::String,
    url: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[node name].freeze

  SHOW_PAGE_ATTRIBUTES = %i[node name url created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[node name url].freeze

  def display_resource(node_link)
    "NodeLink ##{node_link.to_param}"
  end
end
