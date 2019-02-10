# frozen_string_literal: true

describe InterfaceTypePolicy do
  subject { described_class }

  permissions :index? do
    it { is_expected.to permit nil }
  end

  permissions :show? do
    let(:interface_type) { create :interface_type }

    it { is_expected.to permit nil, interface_type }
  end
end
