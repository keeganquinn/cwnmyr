describe Host do
  before(:each) { @host = build_stubbed(:host) }

  subject { @host }

  it { should belong_to(:node) }
  it { should belong_to(:host_type) }
  it { should belong_to(:status) }
  it { should have_many(:interfaces) }
  it { should have_many(:host_properties) }

  it { should respond_to(:name) }
  it { should respond_to(:body) }

  it { should validate_length_of(:name) }

  it "is valid" do
    expect(@host).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @host.id = nil
    expect(@host.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@host.to_param).to match "^#{@host.id}-#{@host.name}$"
  end

  describe "with database access" do
    before(:each) { @host = build(:host) }

    it { should validate_uniqueness_of(:name).scoped_to(:node_id) }
  end
end
