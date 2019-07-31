# frozen_string_literal: true

describe DeviceType do
  subject(:device_type) { build_stubbed(:device_type) }

  it { is_expected.to belong_to(:build_provider) }
  it { is_expected.to have_many(:devices) }
  it { is_expected.to have_many(:device_builds) }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:body) }

  it { is_expected.to validate_length_of(:code) }
  it { is_expected.to validate_length_of(:name) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    device_type.id = nil
    expect(device_type.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(device_type.to_param).to(
      match "^#{device_type.id}-#{device_type.code}$"
    )
  end

  it 'generates a code if a name is provided' do
    device_type.name = 'Test Device Type'
    device_type.validate
    expect(device_type.code).to match 'test-device-type'
  end

  describe 'with database access' do
    subject(:device_type) { build(:device_type) }

    it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  end
end
