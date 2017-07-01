describe Status do
  before(:each) { @status = FactoryGirl.build(:status) }

  subject { @status }

  it { should have_many(:nodes) }
  it { should have_many(:hosts) }
  it { should have_many(:interfaces) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:color) }
end
