describe Tag do
  before(:each) { @tag = FactoryGirl.build(:tag) }

  subject { @tag }

  it { should have_and_belong_to_many(:nodes) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }

  it { should validate_length_of(:code) }
  it { should validate_uniqueness_of(:code) }
  it { should validate_length_of(:name) }

  it "is valid" do
    expect(@tag).to be_valid
  end

  it "#to_param returns nil" do
    expect(@tag.to_param).to be_nil
  end

  it "#to_param returns a string once saved" do
    @tag.save
    expect(@tag.to_param).to match "#{@tag.id}"
  end

  it "generates a code if a name is provided" do
    @tag.name = 'Test Tag'
    expect(@tag).to be_valid
    expect(@tag.code).to match 'test-tag'
  end
end
