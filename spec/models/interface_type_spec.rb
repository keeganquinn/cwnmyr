describe InterfaceType do
  before(:each) { @interface_type = FactoryGirl.build(:interface_type) }

  subject { @interface_type }

  it { should have_many(:interfaces) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }

  it { should validate_length_of(:code) }
  it { should validate_uniqueness_of(:code) }
  it { should validate_length_of(:name) }

  it "is valid" do
    expect(@interface_type).to be_valid
  end

  it "#to_param returns nil" do
    expect(@interface_type.to_param).to be_nil
  end

  it "#to_param returns a string once saved" do
    @interface_type.save
    expect(@interface_type.to_param).to match "#{@interface_type.id}"
  end

  it "generates a code if a name is provided" do
    @interface_type.name = 'Test Interface Type'
    expect(@interface_type).to be_valid
    expect(@interface_type.code).to match 'test-interface-type'
  end
end
