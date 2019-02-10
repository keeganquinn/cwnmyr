# frozen_string_literal: true

describe HostType do
  subject(:host_type) { build_stubbed(:host_type) }

  it { is_expected.to have_many(:hosts) }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:body) }

  it { is_expected.to validate_length_of(:code) }
  it { is_expected.to validate_length_of(:name) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    host_type.id = nil
    expect(host_type.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(host_type.to_param).to match "^#{host_type.id}-#{host_type.code}$"
  end

  it 'generates a code if a name is provided' do
    host_type.name = 'Test Host Type'
    host_type.validate
    expect(host_type.code).to match 'test-host-type'
  end

  describe 'with database access' do
    subject(:host_type) { build(:host_type) }

    it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  end
end
