# frozen_string_literal: true

describe NodePolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:group_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:group) { build_stubbed :group, users: [group_user] }
  let(:node) { build_stubbed :node, user: current_user, group: group }

  permissions :show?, :graph? do
    let(:node) { create :node }

    it { is_expected.to permit nil, node }
  end

  permissions :new?, :create?, :edit?, :update?, :destroy? do
    it { is_expected.not_to permit nil, node }
    it { is_expected.not_to permit other_user, node }
    it { is_expected.to permit current_user, node }
    it { is_expected.to permit group_user, node }
    it { is_expected.to permit admin, node }
  end
end
