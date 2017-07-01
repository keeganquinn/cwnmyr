describe Interface do
  before(:each) { @interface = FactoryGirl.build(:interface) }

  subject { @interface }

  it { should belong_to(:host) }
  it { should belong_to(:interface_type) }
  it { should belong_to(:status) }
  it { should have_many(:interface_properties) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }
  it { should respond_to(:address_ipv4) }
  it { should respond_to(:address_ipv6) }
  it { should respond_to(:address_mac) }
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
  it { should respond_to(:altitude) }
  it { should respond_to(:essid) }
  it { should respond_to(:security_psk) }
  it { should respond_to(:channel) }
  it { should respond_to(:tx_power) }
  it { should respond_to(:rx_sensitivity) }
  it { should respond_to(:cable_loss) }
  it { should respond_to(:antenna_gain) }
  it { should respond_to(:beamwidth_h) }
  it { should respond_to(:beamwidth_v) }
  it { should respond_to(:azimuth) }
  it { should respond_to(:elevation) }
  it { should respond_to(:polarity) }
end
