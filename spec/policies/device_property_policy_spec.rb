# frozen_string_literal: true

describe DevicePropertyPolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:node) { build_stubbed :node, user: current_user }
  let(:device) { build_stubbed :device, node: node }
  let(:device_property) { build_stubbed :device_property, device: device }

  permissions :show? do
    let(:device_property) { create :device_property }

    it { is_expected.to permit nil, device_property }
  end

  permissions :create?, :update?, :destroy? do
    it { is_expected.not_to permit nil, device_property }
    it { is_expected.not_to permit other_user, device_property }
    it { is_expected.to permit current_user, device_property }
    it { is_expected.to permit admin, device_property }
  end
end
