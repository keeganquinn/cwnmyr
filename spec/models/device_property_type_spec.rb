# frozen_string_literal: true

describe DevicePropertyType do
  subject(:device_property_type) { build_stubbed(:device_property_type) }

  it { is_expected.to have_many(:device_properties) }
  it { is_expected.to have_many(:device_property_options) }

  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:name) }
end
