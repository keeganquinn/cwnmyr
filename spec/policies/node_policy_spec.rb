describe NodePolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:node) { build_stubbed :node, user: current_user }

  permissions :index?, :show?, :graph? do
    it { is_expected.to permit nil }
  end

  permissions :new?, :create? do
    it { is_expected.not_to permit nil }
    it { is_expected.to permit current_user }
  end

  permissions :edit?, :update?, :destroy? do
    it { is_expected.not_to permit nil, node }
    it { is_expected.not_to permit other_user, node }
    it { is_expected.to permit current_user, node }
    it { is_expected.to permit admin, node }
  end
end
