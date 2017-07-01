describe UserLink do
  before(:each) { @user_link = FactoryGirl.build(:user_link) }

  subject { @user_link }

  it { should belong_to(:user) }

  it { should respond_to(:name) }
  it { should respond_to(:url) }
end
