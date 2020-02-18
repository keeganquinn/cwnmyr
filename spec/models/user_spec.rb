# frozen_string_literal: true

describe User do
  subject(:user) { build_stubbed(:user) }

  it { is_expected.to have_and_belong_to_many(:groups) }
  it { is_expected.to have_many(:authorizations) }
  it { is_expected.to have_many(:contacts) }
  it { is_expected.to have_many(:devices) }
  it { is_expected.to have_many(:nodes) }
  it { is_expected.to have_many(:notable_requests) }
  it { is_expected.to have_many(:visits) }

  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:role) }
  it { is_expected.to respond_to(:body) }

  it { is_expected.to allow_value('user@example.com').for(:email) }
  it { is_expected.to allow_value('user+mailbox@example.com').for(:email) }
  it { is_expected.not_to allow_value('not-an-email').for(:email) }
  it { is_expected.to validate_length_of(:code) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    user.id = nil
    expect(user.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(user.to_param).to match "^#{user.id}$"
  end

  it 'generates a code if a name is provided' do
    user.name = 'Test User'
    user.validate
    expect(user.code).to match 'test-user'
  end

  describe 'with a code set' do
    before do
      user.code = 'different'
      user.name = 'Test User'
      user.validate
    end

    it { expect(user.code).to match 'test-user' }
    it { expect(user.name).to match 'Test User' }

    it '#to_param returns a string' do
      expect(user.to_param).to match "^#{user.id}-test-user$"
    end
  end

  it 'gets a default role' do
    user.validate
    expect(user.role).to match 'user'
  end

  it 'allows a role to be set' do
    user.role = 'admin'
    user.validate
    expect(user.role).to match 'admin'
  end

  describe 'with database access' do
    subject(:user) { build(:user) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end
end
