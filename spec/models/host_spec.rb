describe Host do
  before(:each) { @host = FactoryGirl.build(:host) }

  subject { @host }

  it { should belong_to(:node) }
  it { should belong_to(:host_type) }
  it { should belong_to(:status) }
  it { should have_many(:interfaces) }
  it { should have_many(:host_properties) }

  it { should respond_to(:name) }
  it { should respond_to(:body) }

  it { should validate_length_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:node_id) }

  it "is valid" do
    expect(@host).to be_valid
  end

  it "#to_param returns nil" do
    expect(@host.to_param).to be_nil
  end

  it "#to_param returns a string once saved" do
    @host.save
    expect(@host.to_param).to match "#{@host.id}"
  end
end
