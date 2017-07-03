describe Zone do
  before(:each) { @zone = build_stubbed(:zone) }

  subject { @zone }

  it { should have_many(:nodes) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }

  it { should validate_length_of(:code) }
  it { should validate_length_of(:name) }

  it "is valid" do
    expect(@zone).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @zone.id = nil
    expect(@zone.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@zone.to_param).to match "^#{@zone.id}-#{@zone.code}$"
  end

  it "generates a code if a name is provided" do
    @zone.name = 'Test Zone'
    expect(@zone).to be_valid
    expect(@zone.code).to match 'test-zone'
  end

  describe "with database access" do
    before(:each) { @zone = build(:zone) }

    it { should validate_uniqueness_of(:code) }
  end
end
