describe User do
  before(:each) { @user = build_stubbed(:user) }

  subject { @user }

  it { should have_and_belong_to_many(:groups) }
  it { should have_many(:nodes) }
  it { should have_many(:user_links) }

  it { should respond_to(:email) }
  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:role) }
  it { should respond_to(:body) }

  it { should allow_value("user@example.com").for(:email) }
  it { should_not allow_value("not-an-email").for(:email) }
  it { should validate_length_of(:code) }

  it "is valid" do
    expect(@user).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @user.id = nil
    expect(@user.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@user.to_param).to match "^#{@user.id}$"
  end

  it "generates a code if a name is provided" do
    @user.name = 'Test User'
    expect(@user).to be_valid
    expect(@user.code).to match 'test-user'
  end

  describe "with a code set" do
    before(:each) {
      @user.code = 'different'
      @user.name = 'Test User'
    }

    it "is valid" do
      expect(@user).to be_valid
      expect(@user.code).to match 'different'
      expect(@user.name).to match 'Test User'
    end

    it "#to_param returns a string" do
      expect(@user.to_param).to match "^#{@user.id}-different$"
    end
  end

  it "gets a default role" do
    expect(@user).to be_valid
    expect(@user.role).to match 'user'
  end

  it "allows a role to be set" do
    @user.role = 'admin'
    expect(@user).to be_valid
    expect(@user.role).to match 'admin'
  end

  describe "with database access" do
    before(:each) { @user = build(:user) }

    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:code).case_insensitive }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
