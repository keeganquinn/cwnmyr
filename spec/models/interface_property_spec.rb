describe InterfaceProperty do
  before(:each) { @interface_property = FactoryGirl.build(:interface_property) }

  subject { @interface_property }

  it { should belong_to(:interface) }

  it { should respond_to(:key) }
  it { should respond_to(:value) }

  it { should validate_length_of(:key) }
  it { should validate_length_of(:value) }

  it "is valid" do
    expect(@interface_property).to be_valid
  end

  it "#to_param returns nil" do
    expect(@interface_property.to_param).to be_nil
  end

  it "#to_param returns a string once saved" do
    @interface_property.save
    expect(@interface_property.to_param).to match "#{@interface_property.id}"
  end
end
