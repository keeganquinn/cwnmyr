describe Contact do
  before(:each) { @contact = build_stubbed(:contact) }

  subject { @contact }

  it { should have_many(:nodes) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:hidden) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:notes) }

  it { should validate_length_of(:code) }
  it { should validate_length_of(:name) }
  it { should allow_value("user@example.com").for(:email) }
  it { should_not allow_value("not-an-email").for(:email) }

  it "is valid" do
    expect(@contact).to be_valid
  end

  it "#to_param returns nil when unsaved" do
    @contact.id = nil
    expect(@contact.to_param).to be_nil
  end

  it "#to_param returns a string" do
    expect(@contact.to_param).to match "^#{@contact.id}-#{@contact.code}$"
  end

  it "generates a code if a name is provided" do
    @contact.name = 'Test Contact'
    expect(@contact).to be_valid
    expect(@contact.code).to match 'test-contact'
  end

  describe "with database access" do
    before(:each) { @contact = build(:contact) }

    it { should validate_uniqueness_of(:code) }
  end
end
