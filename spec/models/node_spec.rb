# frozen_string_literal: true

describe Node do
  subject(:node) { build_stubbed(:node) }

  it { is_expected.to belong_to(:contact) }
  it { is_expected.to belong_to(:status) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:group) }
  it { is_expected.to belong_to(:zone) }
  it { is_expected.to have_many(:hosts) }
  it { is_expected.to have_many(:node_links) }
  it { is_expected.to have_and_belong_to_many(:tags) }
  it { is_expected.to have_attached_file(:logo) }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:body) }
  it { is_expected.to respond_to(:address) }
  it { is_expected.to respond_to(:latitude) }
  it { is_expected.to respond_to(:longitude) }
  it { is_expected.to respond_to(:hours) }
  it { is_expected.to respond_to(:notes) }

  it { is_expected.to validate_length_of(:code) }
  it { is_expected.to validate_length_of(:name) }

  it 'is valid' do
    expect(node).to be_valid
  end

  it '#to_param returns nil when unsaved' do
    node.id = nil
    expect(node.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(node.to_param).to match "^#{node.id}-#{node.code}$"
  end

  it '#directions_url returns a string' do
    expect(node.directions_url).to match '^https://'
  end

  it 'generates a code if a name is provided' do
    node.name = 'Test Node'
    node.validate
    expect(node.code).to match 'test-node'
  end

  describe 'network diagram' do
    subject(:graph) { node.graph }

    it { is_expected.to respond_to(:to_png) }
  end

  describe 'with database access' do
    subject(:node) { build(:node) }

    it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
