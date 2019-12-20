# frozen_string_literal: true

describe DeviceProperty do
  subject(:device_property) { build_stubbed(:device_property, device: device) }

  let(:device) { build_stubbed(:device) }
  let(:device_property_type) { device_property.device_property_type }

  it { is_expected.to belong_to(:device) }
  it { is_expected.to belong_to(:device_property_type) }

  it { is_expected.to respond_to(:value) }

  it { is_expected.to validate_length_of(:value) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    device_property.id = nil
    expect(device_property.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(device_property.to_param).to(
      match "^#{device_property.id}-#{device_property_type.code}$"
    )
  end
end
