describe NodeLink do
  before(:each) { @node_link = FactoryGirl.build(:node_link) }

  subject { @node_link }

  it { should belong_to(:node) }

  it { should respond_to(:name) }
  it { should respond_to(:url) }
end
