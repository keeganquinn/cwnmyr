describe InterfaceProperty do
  before(:each) { @interface_property = FactoryGirl.build(:interface_property) }

  subject { @interface_property }

  it { should belong_to(:interface) }

  it { should respond_to(:key) }
  it { should respond_to(:value) }
end
