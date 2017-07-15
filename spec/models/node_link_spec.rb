describe NodeLink do
  subject(:node_link) { build_stubbed(:node_link) }

  it { is_expected.to belong_to(:node) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:url) }

  it { is_expected.to validate_length_of(:name) }
  it { is_expected.to validate_length_of(:url) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    node_link.id = nil
    expect(node_link.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(node_link.to_param).to(
      match "^#{node_link.id}-#{node_link.name.parameterize}$"
    )
  end
end
