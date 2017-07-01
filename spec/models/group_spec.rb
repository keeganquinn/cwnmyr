describe Group do
  before(:each) { @group = FactoryGirl.build(:group) }

  subject { @group }

  it { should have_and_belong_to_many(:users) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
  it { should respond_to(:body) }
end
