# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the User model.
class UserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    email: Field::Email,
    password: Field::String,
    password_confirmation: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String,
    last_sign_in_ip: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    confirmation_sent_at: Field::DateTime,
    unconfirmed_email: Field::Email,
    code: Field::String,
    name: Field::String,
    role: Field::String.with_options(searchable: false),
    body: Field::Text,
    groups: Field::HasMany,
    contacts: Field::HasMany,
    nodes: Field::HasMany,
    user_links: Field::HasMany
  }.freeze

  COLLECTION_ATTRIBUTES = %i[email name role].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    email encrypted_password reset_password_token reset_password_sent_at
    remember_created_at sign_in_count current_sign_in_at last_sign_in_at
    current_sign_in_ip last_sign_in_ip created_at updated_at
    confirmation_token confirmed_at confirmation_sent_at unconfirmed_email
    code name role body groups contacts nodes user_links
  ].freeze

  FORM_ATTRIBUTES = %i[email password password_confirmation
                       name role body groups].freeze

  def display_resource(user)
    "User ##{user.to_param}"
  end
end
