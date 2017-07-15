describe Interface do
  subject(:interface) { build_stubbed(:interface) }

  it { is_expected.to belong_to(:host) }
  it { is_expected.to belong_to(:interface_type) }
  it { is_expected.to belong_to(:status) }
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

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    interface.id = nil
    expect(interface.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(interface.to_param).to match "^#{interface.id}-#{interface.code}$"
  end
end
