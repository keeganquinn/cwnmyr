# frozen_string_literal: true

describe InterfaceProperty do
  subject(:interface_property) { build_stubbed(:interface_property) }

  it { is_expected.to belong_to(:interface) }

  it { is_expected.to respond_to(:key) }
  it { is_expected.to respond_to(:value) }

  it { is_expected.to validate_length_of(:key) }
  it { is_expected.to validate_length_of(:value) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    interface_property.id = nil
    expect(interface_property.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(interface_property.to_param).to(
      match "^#{interface_property.id}-#{interface_property.key}$"
    )
  end
end
