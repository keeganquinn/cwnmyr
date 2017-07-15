describe Status do
  subject(:status) { build_stubbed(:status) }

  it { is_expected.to have_many(:nodes) }
  it { is_expected.to have_many(:hosts) }
  it { is_expected.to have_many(:interfaces) }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:color) }

  it { is_expected.to validate_length_of(:code) }
  it { is_expected.to validate_length_of(:name) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    status.id = nil
    expect(status.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(status.to_param).to match "^#{status.id}-#{status.code}$"
  end

  it 'generates a code if a name is provided' do
    status.name = 'Test Status'
    status.validate
    expect(status.code).to match 'test-status'
  end

  describe 'with database access' do
    subject(:status) { build(:status) }

    it { is_expected.to validate_uniqueness_of(:code) }
  end
end
