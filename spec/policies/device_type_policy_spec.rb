# frozen_string_literal: true

describe DeviceTypePolicy do
  subject { described_class }

  permissions :index? do
    it { is_expected.to permit nil }
  end

  permissions :show? do
    let(:device_type) { create :device_type }

    it { is_expected.to permit nil, device_type }
  end
end
