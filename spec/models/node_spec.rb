describe Node do
  before(:each) { @node = build_stubbed(:node) }

  subject { @node }

  it { should belong_to(:contact) }
  it { should belong_to(:status) }
  it { should belong_to(:user) }
  it { should belong_to(:zone) }
  it { should have_many(:hosts) }
  it { should have_many(:node_links) }
  it { should have_and_belong_to_many(:tags) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }
  it { should respond_to(:address) }
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
  it { should respond_to(:hours) }
  it { should respond_to(:notes) }

  it { should validate_length_of(:code) }
  it { should validate_length_of(:name) }

  it "is valid" do
    expect(@node).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @node.id = nil
    expect(@node.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@node.to_param).to match "^#{@node.id}-#{@node.code}$"
  end

  it "generates a code if a name is provided" do
    @node.name = 'Test Node'
    expect(@node).to be_valid
    expect(@node.code).to match 'test-node'
  end

  describe "network diagram" do
    subject { @node.graph }

    it { should respond_to(:to_png) }
  end

  describe "with database access" do
    before(:each) { @node = build(:node) }

    it { should validate_uniqueness_of(:code) }
    it { should validate_uniqueness_of(:name) }
  end
end
