describe Contact do
  before(:each) { @contact = FactoryGirl.build(:contact) }

  subject { @contact }

  it { should have_many(:nodes) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:hidden) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:notes) }
end
