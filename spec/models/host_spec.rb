describe Host do
  before(:each) { @host = FactoryGirl.build(:host) }

  subject { @host }

  it { should belong_to(:node) }
  it { should belong_to(:host_type) }
  it { should belong_to(:status) }
  it { should have_many(:host_properties) }

  it { should respond_to(:name) }
  it { should respond_to(:body) }
end
