# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the AuthorizedHost model.
class AuthorizedHostDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    device: Field::BelongsTo,
    name: Field::String,
    address_mac: Field::String,
    address_ipv4: Field::String,
    address_ipv6: Field::String,
    comment: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[device name address_mac].freeze

  SHOW_PAGE_ATTRIBUTES = %i[device name address_mac address_ipv4 address_ipv6
                            comment created_at updated_at].freeze

  FORM_ATTRIBUTES = %i[device name address_mac address_ipv4 address_ipv6
                       comment].freeze

  # Display representation of the resource.
  def display_resource(authorized_host)
    "Authorized Host ##{authorized_host.to_param}"
  end
end
