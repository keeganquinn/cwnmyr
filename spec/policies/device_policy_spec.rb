# frozen_string_literal: true

describe DevicePolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:node) { build_stubbed :node, user: current_user }
  let(:device) { build_stubbed :device, node: node }

  permissions :show?, :graph? do
    let(:device) { create :device }

    it { is_expected.to permit nil, device }
  end

  permissions :new?, :create?, :edit?, :update?, :destroy? do
    it { is_expected.not_to permit nil, device }
    it { is_expected.not_to permit other_user, device }
    it { is_expected.to permit current_user, device }
    it { is_expected.to permit admin, device }
  end
end
