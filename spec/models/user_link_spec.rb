describe UserLink do
  before(:each) { @user_link = build_stubbed(:user_link) }

  subject { @user_link }

  it { should belong_to(:user) }

  it { should respond_to(:name) }
  it { should respond_to(:url) }

  it { should validate_length_of(:name) }
  it { should validate_length_of(:url) }

  it "is valid" do
    expect(@user_link).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @user_link.id = nil
    expect(@user_link.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@user_link.to_param).to match "^#{@user_link.id}-#{@user_link.name.parameterize}$"
  end
end
