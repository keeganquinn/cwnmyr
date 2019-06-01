# frozen_string_literal: true

describe GroupPolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:group) { build_stubbed :group, users: [current_user] }

  permissions :update? do
    let(:group) { create :group }

    it { is_expected.not_to permit nil, group }
    it { is_expected.not_to permit other_user, group }
    it { is_expected.to permit admin, group }
  end
end
