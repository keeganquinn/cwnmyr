describe Zone do
  before(:each) { @zone = FactoryGirl.build(:zone) }

  subject { @zone }

  it { should have_many(:nodes) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }
end
