describe InterfaceType do
  before(:each) { @interface_type = build_stubbed(:interface_type) }

  subject { @interface_type }

  it { should have_many(:interfaces) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }

  it { should validate_length_of(:code) }
  it { should validate_length_of(:name) }

  it "is valid" do
    expect(@interface_type).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @interface_type.id = nil
    expect(@interface_type.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@interface_type.to_param).to match "^#{@interface_type.id}-#{@interface_type.code}$"
  end

  it "generates a code if a name is provided" do
    @interface_type.name = 'Test Interface Type'
    expect(@interface_type).to be_valid
    expect(@interface_type.code).to match 'test-interface-type'
  end

  describe "with database access" do
    before(:each) { @interface_type = build(:interface_type) }

    it { should validate_uniqueness_of(:code) }
  end
end
