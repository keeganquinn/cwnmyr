describe HostProperty do
  before(:each) { @host_property = build_stubbed(:host_property) }

  subject { @host_property }

  it { should belong_to(:host) }

  it { should respond_to(:key) }
  it { should respond_to(:value) }

  it { should validate_length_of(:key) }
  it { should validate_length_of(:value) }

  it "is valid" do
    expect(@host_property).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @host_property.id = nil
    expect(@host_property.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@host_property.to_param).to match "^#{@host_property.id}-#{@host_property.key}$"
  end
end
