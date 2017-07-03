describe UserLink do
  before(:each) { @user_link = FactoryGirl.build(:user_link) }

  subject { @user_link }

  it { should belong_to(:user) }

  it { should respond_to(:name) }
  it { should respond_to(:url) }

  it { should validate_length_of(:name) }
  it { should validate_length_of(:url) }

  it "is valid" do
    expect(@user_link).to be_valid
  end

  it "#to_param returns nil" do
    expect(@user_link.to_param).to be_nil
  end

  it "#to_param returns a string once saved" do
    @user_link.save
    expect(@user_link.to_param).to match "#{@user_link.id}"
  end
end
