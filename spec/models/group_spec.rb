describe Group do
  before(:each) { @group = build_stubbed(:group) }

  subject { @group }

  it { should have_and_belong_to_many(:users) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }

  it { should validate_length_of(:code) }
  it { should validate_length_of(:name) }

  it "is valid" do
    expect(@group).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @group.id = nil
    expect(@group.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@group.to_param).to match "^#{@group.id}-#{@group.code}$"
  end

  it "generates a code if a name is provided" do
    @group.name = 'Test User'
    expect(@group).to be_valid
    expect(@group.code).to match 'test-user'
  end

  describe "with database access" do
    before(:each) { @group = build(:group) }

    it { should validate_uniqueness_of(:code) }
  end
end
