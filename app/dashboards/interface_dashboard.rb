# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the Interface model.
class InterfaceDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    device: Field::BelongsTo,
    code: Field::String,
    name: Field::String,
    interface_type: Field::BelongsTo,
    body: Field::Text,
    address_ipv4: Field::String,
    address_ipv6: Field::String,
    address_mac: Field::String,
    latitude: Field::Number,
    longitude: Field::Number,
    altitude: Field::Number,
    essid: Field::String,
    security_psk: Field::String,
    channel: Field::String,
    tx_power: Field::Number,
    rx_sensitivity: Field::Number,
    cable_loss: Field::Number,
    antenna_gain: Field::Number,
    beamwidth_h: Field::Number,
    beamwidth_v: Field::Number,
    azimuth: Field::Number,
    elevation: Field::Number,
    polarity: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[device code name interface_type].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    device code name interface_type body
    address_ipv4 address_ipv6 address_mac latitude longitude altitude
    essid security_psk channel tx_power rx_sensitivity cable_loss antenna_gain
    beamwidth_h beamwidth_v azimuth elevation polarity created_at updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    device code name interface_type body
    address_ipv4 address_ipv6 address_mac latitude longitude altitude
    essid security_psk channel tx_power rx_sensitivity cable_loss antenna_gain
    beamwidth_h beamwidth_v azimuth elevation polarity
  ].freeze

  def display_resource(interface)
    "Interface ##{interface.to_param}"
  end
end
