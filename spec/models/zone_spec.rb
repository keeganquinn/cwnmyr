# frozen_string_literal: true

describe Zone do
  subject(:zone) { build_stubbed(:zone) }

  it { is_expected.to have_many(:nodes) }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:body) }

  it { is_expected.to validate_length_of(:code) }
  it { is_expected.to validate_length_of(:name) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    zone.id = nil
    expect(zone.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(zone.to_param).to match "^#{zone.id}-#{zone.code}$"
  end

  it 'generates a code if a name is provided' do
    zone.name = 'Test Zone'
    zone.validate
    expect(zone.code).to match 'test-zone'
  end

  describe 'with database access' do
    subject(:zone) { build(:zone) }

    it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  end

  describe 'with images' do
    subject(:zone) { build(:zone, :with_images) }

    it { expect(zone.nav_logo_stamp).to be >= 0 }
  end
end
