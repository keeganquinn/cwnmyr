describe InterfacePolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:node) { build_stubbed :node, user: current_user }
  let(:host) { build_stubbed :host, node: node }
  let(:interface) { build_stubbed :interface, host: host }

  permissions :index?, :show? do
    it { is_expected.to permit nil }
  end

  permissions :create?, :update?, :destroy? do
    it { is_expected.not_to permit nil, interface }
    it { is_expected.not_to permit other_user, interface }
    it { is_expected.to permit current_user, interface }
    it { is_expected.to permit admin, interface }
  end
end
