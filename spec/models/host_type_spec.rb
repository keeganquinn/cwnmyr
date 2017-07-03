describe HostType do
  before(:each) { @host_type = build_stubbed(:host_type) }

  subject { @host_type }

  it { should have_many(:hosts) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }

  it { should validate_length_of(:code) }
  it { should validate_length_of(:name) }

  it "is valid" do
    expect(@host_type).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @host_type.id = nil
    expect(@host_type.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@host_type.to_param).to match "^#{@host_type.id}-#{@host_type.code}$"
  end

  it "generates a code if a name is provided" do
    @host_type.name = 'Test Host Type'
    expect(@host_type).to be_valid
    expect(@host_type.code).to match 'test-host-type'
  end

  describe "with database access" do
    before(:each) { @host_type = build(:host_type) }

    it { should validate_uniqueness_of(:code) }
  end
end
