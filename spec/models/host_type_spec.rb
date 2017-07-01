describe HostType do
  before(:each) { @host_type = FactoryGirl.build(:host_type) }

  subject { @host_type }

  it { should have_many(:hosts) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }
end
