# frozen_string_literal: true

# Service to populate various records used to represent selections in
# imported data.
class PopulateOptionsService
  ZONES = [{
    code: 'pdx',
    name: 'Portland',
    title: 'Personal Telco Nodes',
    default: true,
    address: '727 SE Grand Ave, Portland, OR 97214',
    zoom_default: 17,
    zoom_min: 12,
    zoom_max: 18
  }].freeze
  GROUPS = [{ code: 'not', name: 'Network Operations Team' }].freeze
  BUILD_PROVIDERS = [{
    code: 'qtk',
    name: 'jenkins.quinn.tk',
    url: 'https://jenkins.quinn.tk/job/cwnmyr-build/',
    server: 'jenkins.quinn.tk',
    job: 'cwnmyr-build'
  }].freeze

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
  NETWORKS = [
    { code: 'test', name: 'Test Interface' },
    { code: 'ptpnet', name: 'PTPnet', allow_neighbors: true }
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
      *BUILD_PROVIDERS.map { |vals| make_one BuildProvider, vals },
      *DEVICE_TYPES.map { |vals| make_one DeviceType, vals },
      *NETWORKS.map { |vals| make_one Network, vals },
      *STATUSES.map { |vals| make_one Status, vals },
      *ZONES.map { |vals| make_one Zone, vals }
    ]
  end

  def make_one(klass, vals)
    item = klass.find_or_create_by code: vals[:code]
    item.update_attributes vals
  end
end
