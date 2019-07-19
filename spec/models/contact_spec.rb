# frozen_string_literal: true

describe Contact do
  subject(:contact) { build_stubbed(:contact) }

  it { is_expected.to have_many(:nodes) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:group) }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:hidden) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:phone) }
  it { is_expected.to respond_to(:notes) }

  it { is_expected.to validate_length_of(:code) }
  it { is_expected.to validate_length_of(:name) }
  it { is_expected.to allow_value('user@example.com').for(:email) }
  it { is_expected.not_to allow_value('not-an-email').for(:email) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    contact.id = nil
    expect(contact.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(contact.to_param).to match "^#{contact.id}-#{contact.code}$"
  end

  it 'generates a code if a name is provided' do
    contact.name = 'Test Contact'
    contact.validate
    expect(contact.code).to match 'test-contact'
  end
end
