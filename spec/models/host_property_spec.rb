# frozen_string_literal: true

describe HostProperty do
  subject(:host_property) { build_stubbed(:host_property) }

  it { is_expected.to belong_to(:host) }

  it { is_expected.to respond_to(:key) }
  it { is_expected.to respond_to(:value) }

  it { is_expected.to validate_length_of(:key) }
  it { is_expected.to validate_length_of(:value) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    host_property.id = nil
    expect(host_property.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(host_property.to_param).to(
      match "^#{host_property.id}-#{host_property.key}$"
    )
  end
end
