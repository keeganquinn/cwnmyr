# frozen_string_literal: true

describe Interface do
  subject(:interface) { build_stubbed :interface }

  it { is_expected.to belong_to(:host) }
  it { is_expected.to belong_to(:interface_type) }
  it { is_expected.to have_many(:interface_properties) }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:body) }
  it { is_expected.to respond_to(:address_ipv4) }
  it { is_expected.to respond_to(:address_ipv6) }
  it { is_expected.to respond_to(:address_mac) }
  it { is_expected.to respond_to(:latitude) }
  it { is_expected.to respond_to(:longitude) }
  it { is_expected.to respond_to(:altitude) }
  it { is_expected.to respond_to(:essid) }
  it { is_expected.to respond_to(:security_psk) }
  it { is_expected.to respond_to(:channel) }
  it { is_expected.to respond_to(:tx_power) }
  it { is_expected.to respond_to(:rx_sensitivity) }
  it { is_expected.to respond_to(:cable_loss) }
  it { is_expected.to respond_to(:antenna_gain) }
  it { is_expected.to respond_to(:beamwidth_h) }
  it { is_expected.to respond_to(:beamwidth_v) }
  it { is_expected.to respond_to(:azimuth) }
  it { is_expected.to respond_to(:elevation) }
  it { is_expected.to respond_to(:polarity) }

  it { is_expected.to validate_length_of(:code) }
  it { is_expected.to allow_value('10.11.23.3/24').for(:address_ipv4) }
  it { is_expected.not_to allow_value('junk').for(:address_ipv4) }
  it { is_expected.to allow_value('::1/128').for(:address_ipv6) }
  it { is_expected.not_to allow_value('junk').for(:address_ipv6) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    interface.id = nil
    expect(interface.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(interface.to_param).to match "^#{interface.id}-#{interface.code}$"
  end

  it '#ipv4_cidr returns nil without an address' do
    expect(interface.ipv4_cidr).to be_nil
  end

  it '#ipv4_neighbors returns an empty list without an address' do
    expect(interface.ipv4_neighbors).to be_empty
  end

  describe 'IPv4 neighbors' do
    let(:network) { create :interface_type, allow_neighbors: true }
    let!(:local) do
      create :interface, interface_type: network, address_ipv4: '10.11.23.2/24'
    end
    let!(:remote) do
      create :interface, interface_type: network, address_ipv4: '10.11.23.3/24'
    end

    it 'are on the same network' do
      expect(local.interface_type).to eq(remote.interface_type)
    end

    it 'share an interface type' do
      expect(local.interface_type.interfaces).to include(remote)
    end

    it 'are detected' do
      expect(local.ipv4_neighbors).to include(remote)
    end
  end

  describe 'with database access' do
    subject(:interface) { build(:interface) }

    it do
      expect(subject).to(
        validate_uniqueness_of(:code).scoped_to(:host_id).case_insensitive
      )
    end
  end
end
