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
    { code: 'airrouter', name: 'Ubiquiti AirRouter' },
    { code: 'alix', name: 'PC Engines ALIX' },
    { code: 'apu', name: 'PC Engines APU' },
    { code: 'bullet', name: 'Ubiquiti Bullet' },
    { code: 'dir860l', name: 'D-Link DIR-860L' },
    { code: 'erx', name: 'Ubiquiti EdgeRouter ERX' },
    { code: 'espbin', name: 'Globalscale ESPRESSObin' },
    { code: 'mr24', name: 'Meraki MR24' },
    { code: 'mr3201a', name: 'Accton MR3201A' },
    { code: 'net4521', name: 'Soekris net4521' },
    { code: 'net4826', name: 'Soekris net4826' },
    { code: 'rb493g', name: 'MikroTik RouterBOARD 493G' },
    { code: 'rocket', name: 'Ubiquiti Rocket' },
    { code: 'rsta', name: 'Ubiquiti RouterStation' },
    { code: 'wdr3600', name: 'TP-Link TL-WDR3600' },
    { code: 'wgt634u', name: 'Netgear WGT634U' },
    { code: 'wndr3800', name: 'Netgear WNDR3800' },
    { code: 'wzr600dhp', name: 'Buffalo WZR-600DHP' }
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
