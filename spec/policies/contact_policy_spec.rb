# frozen_string_literal: true

describe ContactPolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:contact) { build_stubbed :contact, user: current_user }
  let(:hidden_contact) { build_stubbed :contact, hidden: true }

  permissions :show? do
    let(:contact) { create :contact }

    it { is_expected.to permit nil, contact }
    it { is_expected.not_to permit nil, hidden_contact }
    it { is_expected.to permit other_user, contact }
    it { is_expected.not_to permit other_user, hidden_contact }
  end

  permissions :new?, :create?, :edit?, :update?, :destroy? do
    it { is_expected.not_to permit nil, contact }
    it { is_expected.not_to permit other_user, contact }
  end

  permissions :show?, :new?, :create?, :edit?, :update?, :destroy? do
    it { is_expected.to permit current_user, contact }
    it { is_expected.to permit admin, contact }
    it { is_expected.not_to permit current_user, hidden_contact }
    it { is_expected.to permit admin, hidden_contact }
  end
end
