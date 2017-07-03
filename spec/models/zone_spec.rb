describe Zone do
  before(:each) { @zone = FactoryGirl.build(:zone) }

  subject { @zone }

  it { should have_many(:nodes) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }

  it { should validate_length_of(:code) }
  it { should validate_uniqueness_of(:code) }
  it { should validate_length_of(:name) }

  it "is valid" do
    expect(@zone).to be_valid
  end

  it "#to_param returns nil" do
    expect(@zone.to_param).to be_nil
  end

  it "#to_param returns a string once saved" do
    @zone.save
    expect(@zone.to_param).to match "#{@zone.id}"
  end

  it "generates a code if a name is provided" do
    @zone.name = 'Test Zone'
    expect(@zone).to be_valid
    expect(@zone.code).to match 'test-zone'
  end
end
