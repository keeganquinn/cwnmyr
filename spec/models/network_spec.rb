# frozen_string_literal: true

describe Network do
  subject(:network) { build_stubbed(:network) }

  it { is_expected.to have_many(:interfaces) }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:body) }

  it { is_expected.to validate_length_of(:code) }
  it { is_expected.to validate_length_of(:name) }
  it { is_expected.to allow_value('10.11.23.3/24').for(:network_ipv4) }
  it { is_expected.not_to allow_value('junk').for(:network_ipv4) }
  it { is_expected.to allow_value('::1/128').for(:network_ipv6) }
  it { is_expected.not_to allow_value('junk').for(:network_ipv6) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    network.id = nil
    expect(network.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(network.to_param).to(
      match "^#{network.id}-#{network.code}$"
    )
  end

  it 'generates a code if a name is provided' do
    network.name = 'Test Network'
    network.validate
    expect(network.code).to match 'test-network'
  end

  describe 'with database access' do
    subject(:network) { build(:network) }

    it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  end
end
