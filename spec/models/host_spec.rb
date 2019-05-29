# frozen_string_literal: true

describe Host do
  subject(:host) { build_stubbed(:host) }

  it { is_expected.to belong_to(:node) }
  it { is_expected.to belong_to(:host_type) }
  it { is_expected.to have_many(:interfaces) }
  it { is_expected.to have_many(:host_properties) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:body) }

  it { is_expected.to validate_length_of(:name) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    host.id = nil
    expect(host.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(host.to_param).to match "^#{host.id}-#{host.name}$"
  end

  describe 'with database access' do
    subject(:host) { build(:host) }

    it do
      expect(host).to(
        validate_uniqueness_of(:name).scoped_to(:node_id).case_insensitive
      )
    end
  end
end
