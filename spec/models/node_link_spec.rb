describe NodeLink do
  before(:each) { @node_link = build_stubbed(:node_link) }

  subject { @node_link }

  it { should belong_to(:node) }

  it { should respond_to(:name) }
  it { should respond_to(:url) }

  it { should validate_length_of(:name) }
  it { should validate_length_of(:url) }

  it "is valid" do
    expect(@node_link).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @node_link.id = nil
    expect(@node_link.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@node_link.to_param).to match "^#{@node_link.id}-#{@node_link.name.parameterize}$"
  end
end
