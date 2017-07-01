describe InterfaceType do
  before(:each) { @interface_type = FactoryGirl.build(:interface_type) }

  subject { @interface_type }

  it { should have_many(:interfaces) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }
end
