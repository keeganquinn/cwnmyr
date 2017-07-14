describe HostPolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:node) { build_stubbed :node, user: current_user }
  let(:host) { build_stubbed :host, node: node }

  permissions :index?, :show? do
    it { is_expected.to permit nil }
  end

  permissions :create?, :update?, :destroy? do
    it { is_expected.not_to permit nil, host }
    it { is_expected.not_to permit other_user, host }
    it { is_expected.to permit current_user, host }
    it { is_expected.to permit admin, host }
  end
end
