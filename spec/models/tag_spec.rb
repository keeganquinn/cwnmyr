describe Tag do
  subject(:tag) { build_stubbed(:tag) }

  it { is_expected.to have_and_belong_to_many(:nodes) }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }

  it { is_expected.to validate_length_of(:code) }
  it { is_expected.to validate_length_of(:name) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    tag.id = nil
    expect(tag.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(tag.to_param).to match "^#{tag.id}-#{tag.code}$"
  end

  it 'generates a code if a name is provided' do
    tag.name = 'Test Tag'
    tag.validate
    expect(tag.code).to match 'test-tag'
  end

  describe 'with database access' do
    subject(:tag) { build(:tag) }

    it { is_expected.to validate_uniqueness_of(:code) }
  end
end
