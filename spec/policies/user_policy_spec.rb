# frozen_string_literal: true

describe UserPolicy do
  subject { described_class }

  permissions :index? do
    it { is_expected.to permit nil }
  end

  permissions :show? do
    let(:user) { create :user }

    it { is_expected.to permit nil, user }
  end

  permissions :update?, :confirm?, :revoke? do
    let(:user) { build_stubbed :user }

    it { is_expected.not_to permit nil, user }
    it { is_expected.to permit user, user }
  end
end
