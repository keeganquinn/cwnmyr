describe HostProperty do
  before(:each) { @host_property = FactoryGirl.build(:host_property) }

  subject { @host_property }

  it { should belong_to(:host) }

  it { should respond_to(:key) }
  it { should respond_to(:value) }
end
