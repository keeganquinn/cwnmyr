describe InterfaceType do
  subject(:interface_type) { build_stubbed(:interface_type) }

  it { is_expected.to have_many(:interfaces) }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:body) }

  it { is_expected.to validate_length_of(:code) }
  it { is_expected.to validate_length_of(:name) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    interface_type.id = nil
    expect(interface_type.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(interface_type.to_param).to(
      match "^#{interface_type.id}-#{interface_type.code}$"
    )
  end

  it 'generates a code if a name is provided' do
    interface_type.name = 'Test Interface Type'
    interface_type.validate
    expect(interface_type.code).to match 'test-interface-type'
  end

  describe 'with database access' do
    subject(:interface_type) { build(:interface_type) }

    it { is_expected.to validate_uniqueness_of(:code) }
  end
end
