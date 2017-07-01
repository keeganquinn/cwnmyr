describe Tag do
  before(:each) { @tag = FactoryGirl.build(:tag) }

  subject { @tag }

  it { should have_and_belong_to_many(:nodes) }

  it { should respond_to(:code) }
  it { should respond_to(:name) }
end
