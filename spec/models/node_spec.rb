describe Node do
  before(:each) { @node = FactoryGirl.build(:node) }

  subject { @node }

  it { should belong_to(:contact) }
  it { should belong_to(:status) }
  it { should belong_to(:user) }
  it { should belong_to(:zone) }
  it { should have_many(:hosts) }
  it { should have_many(:node_links) }
  it { should have_and_belong_to_many(:tags) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }
  it { should respond_to(:address) }
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
  it { should respond_to(:hours) }
  it { should respond_to(:notes) }
end
