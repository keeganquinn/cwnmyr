# frozen_string_literal: true

describe DevicePropertyOption do
  subject(:device_property_option) { build_stubbed(:device_property_option) }

  it { is_expected.to belong_to(:device_property_type) }
  it { is_expected.to have_many(:device_properties) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:value) }
end
