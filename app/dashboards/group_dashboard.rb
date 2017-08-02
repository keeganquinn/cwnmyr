require 'administrate/base_dashboard'

# Administrate Dashboard for the Group model.
class GroupDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    body: Field::Text,
    contacts: Field::HasMany,
    nodes: Field::HasMany,
    users: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[code name].freeze

  SHOW_PAGE_ATTRIBUTES = %i[code name body contacts nodes users
                            created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[code name body users].freeze

  def display_resource(group)
    "Group ##{group.to_param}"
  end
end
