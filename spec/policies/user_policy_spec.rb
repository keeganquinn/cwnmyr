describe UserPolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  permissions :index? do
    it { is_expected.not_to permit current_user }
    it { is_expected.to permit admin }
  end

  permissions :show? do
    it { is_expected.not_to permit nil }
    it { is_expected.to permit current_user }
  end

  permissions :update?, :destroy? do
    it { is_expected.not_to permit current_user, current_user }
    it { is_expected.to permit admin, current_user }
  end
end
