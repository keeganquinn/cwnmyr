require "administrate/base_dashboard"

class UserLinkDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    user: Field::BelongsTo,
    name: Field::String,
    url: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :user,
    :name,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :user,
    :name,
    :url,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :user,
    :name,
    :url,
  ].freeze

  def display_resource(user_link)
    "UserLink ##{user_link.to_param}"
  end
end
