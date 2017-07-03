describe NodeLink do
  before(:each) { @node_link = FactoryGirl.build(:node_link) }

  subject { @node_link }

  it { should belong_to(:node) }

  it { should respond_to(:name) }
  it { should respond_to(:url) }

  it { should validate_length_of(:name) }
  it { should validate_length_of(:url) }

  it "is valid" do
    expect(@node_link).to be_valid
  end

  it "#to_param returns nil" do
    expect(@node_link.to_param).to be_nil
  end

  it "#to_param returns a string once saved" do
    @node_link.save
    expect(@node_link.to_param).to match "#{@node_link.id}"
  end
end
