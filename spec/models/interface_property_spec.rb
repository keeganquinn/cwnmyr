describe InterfaceProperty do
  before(:each) { @interface_property = build_stubbed(:interface_property) }

  subject { @interface_property }

  it { should belong_to(:interface) }

  it { should respond_to(:key) }
  it { should respond_to(:value) }

  it { should validate_length_of(:key) }
  it { should validate_length_of(:value) }

  it "is valid" do
    expect(@interface_property).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @interface_property.id = nil
    expect(@interface_property.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@interface_property.to_param).to match "^#{@interface_property.id}-#{@interface_property.key}$"
  end
end
