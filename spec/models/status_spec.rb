describe Status do
  before(:each) { @status = FactoryGirl.build(:status) }

  subject { @status }

  it { should have_many(:nodes) }
  it { should have_many(:hosts) }
  it { should have_many(:interfaces) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:color) }

  it { should validate_length_of(:code) }
  it { should validate_uniqueness_of(:code) }
  it { should validate_length_of(:name) }

  it "is valid" do
    expect(@status).to be_valid
  end

  it "#to_param returns nil" do
    expect(@status.to_param).to be_nil
  end

  it "#to_param returns a string once saved" do
    @status.save
    expect(@status.to_param).to match "#{@status.id}"
  end

  it "generates a code if a name is provided" do
    @status.name = 'Test Status'
    expect(@status).to be_valid
    expect(@status.code).to match 'test-status'
  end
end
