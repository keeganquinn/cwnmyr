# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the Event model.
class EventDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    user: Field::BelongsTo,
    group: Field::BelongsTo,
    name: Field::String,
    description: Field::Text,
    action_url: Field::String,
    action_priority: Field::Boolean,
    action_text: Field::String,
    starts_at: Field::DateTime,
    ends_at: Field::DateTime,
    splash_position: Field::String,
    published: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[user name starts_at published].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    user group name description action_url action_priority action_text
    starts_at ends_at splash_position published created_at updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    user group name description action_url action_priority action_text
    starts_at ends_at splash_position published
  ].freeze

  def display_resource(event)
    event.name
  end
end
