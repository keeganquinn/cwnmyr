require "administrate/base_dashboard"

class GroupDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    body: Field::Text,
    users: Field::HasMany,
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
    :users,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :code,
    :name,
    :body,
    :users,
  ].freeze

  def display_resource(group)
    "Group ##{group.to_param}"
  end
end
