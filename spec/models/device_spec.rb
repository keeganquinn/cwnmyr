# frozen_string_literal: true

describe Device do
  subject(:device) { build_stubbed(:device) }

  it { is_expected.to belong_to(:node) }
  it { is_expected.to belong_to(:device_type).optional }
  it { is_expected.to have_many(:authorized_hosts) }
  it { is_expected.to have_many(:interfaces) }
  it { is_expected.to have_many(:device_builds) }
  it { is_expected.to have_many(:device_properties) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:body) }

  it { is_expected.to validate_length_of(:name) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    device.id = nil
    expect(device.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(device.to_param).to match "^#{device.id}-#{device.name}$"
  end

  describe 'with database access' do
    subject(:device) { build(:device) }

    it do
      expect(device).to(
        validate_uniqueness_of(:name).scoped_to(:node_id).case_insensitive
      )
    end
  end
end
