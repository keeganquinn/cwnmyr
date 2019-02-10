# frozen_string_literal: true

describe Group do
  subject(:group) { build_stubbed(:group) }

  it { is_expected.to have_many(:contacts) }
  it { is_expected.to have_many(:nodes) }
  it { is_expected.to have_and_belong_to_many(:users) }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:body) }

  it { is_expected.to validate_length_of(:code) }
  it { is_expected.to validate_length_of(:name) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    group.id = nil
    expect(group.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(group.to_param).to match "^#{group.id}-#{group.code}$"
  end

  it 'generates a code if a name is provided' do
    group.name = 'Test User'
    group.validate
    expect(group.code).to match 'test-user'
  end

  describe 'with database access' do
    subject(:group) { build(:group) }

    it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  end
end
