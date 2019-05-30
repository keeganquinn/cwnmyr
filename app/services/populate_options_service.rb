# frozen_string_literal: true

# Service to populate various records used to represent selections in
# imported data.
class PopulateOptionsService
  ZONES = [{ code: 'pdx', name: 'Portland' }].freeze
  GROUPS = [{ code: 'not', name: 'Network Operations Team' }].freeze

  DEVICE_TYPES = [
    { code: 'test', name: 'Test Device' },
    { code: 'airrouter', name: 'AirRouter' },
    { code: 'apu', name: 'APU' },
    { code: 'alix', name: 'ALIX' },
    { code: 'bullet', name: 'BULLET' },
    { code: 'dir860l', name: 'DIR860L' },
    { code: 'mr24', name: 'MR24' },
    { code: 'mr3201a', name: 'MR3201A' },
    { code: 'net4521', name: 'NET4521' },
    { code: 'net4826', name: 'NET4826' },
    { code: 'rb493g', name: 'RB493G' },
    { code: 'rocket', name: 'ROCKET' },
    { code: 'rsta', name: 'RSTA' },
    { code: 'soekris', name: 'Soekris' },
    { code: 'wgt634u', name: 'WGT634U' },
    { code: 'wdr3600', name: 'WDR3600' },
    { code: 'wndr3800', name: 'WNDR3800' },
    { code: 'wzr600dhp', name: 'WZR600DHP' }
  ].freeze
  INTERFACE_TYPES = [
    { code: 'test', name: 'Test Interface' },
    { code: 'pub', name: 'Public Network', allow_neighbors: true },
    { code: 'priv', name: 'Private Network' }
  ].freeze
  STATUSES = [
    { code: 'active', name: 'Active', color: 'green', ordinal: 100,
      default_display: true },
    { code: 'not_ptp_managed', name: 'Not PTP Managed', color: 'blue',
      ordinal: 200, default_display: true },
    { code: 'pending', name: 'Pending', color: 'brown', ordinal: 300 },
    { code: 'inactive', name: 'Inactive', color: 'red', ordinal: 400 },
    { code: 'retired', name: 'Retired', color: 'purple', ordinal: 500 },
    { code: 'test', name: 'Testing', color: 'orange', ordinal: 600 }
  ].freeze

  def call
    [
      *GROUPS.map { |vals| make_one Group, vals },
      *DEVICE_TYPES.map { |vals| make_one DeviceType, vals },
      *INTERFACE_TYPES.map { |vals| make_one InterfaceType, vals },
      *STATUSES.map { |vals| make_one Status, vals },
      *ZONES.map { |vals| make_one Zone, vals }
    ]
  end

  def make_one(klass, vals)
    item = klass.find_or_create_by code: vals[:code]
    item.update_attributes vals
  end
end
