describe Tag do
  before(:each) { @tag = build_stubbed(:tag) }

  subject { @tag }

  it { should have_and_belong_to_many(:nodes) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }

  it { should validate_length_of(:code) }
  it { should validate_length_of(:name) }

  it "is valid" do
    expect(@tag).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @tag.id = nil
    expect(@tag.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@tag.to_param).to match "^#{@tag.id}-#{@tag.code}$"
  end

  it "generates a code if a name is provided" do
    @tag.name = 'Test Tag'
    expect(@tag).to be_valid
    expect(@tag.code).to match 'test-tag'
  end

  describe "with database access" do
    before(:each) { @tag = build(:tag) }

    it { should validate_uniqueness_of(:code) }
  end
end
