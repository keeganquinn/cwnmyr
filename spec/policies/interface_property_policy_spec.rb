describe InterfacePropertyPolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:node) { build_stubbed :node, user: current_user }
  let(:host) { build_stubbed :host, node: node }
  let(:interface) { build_stubbed :interface, host: host }
  let(:interface_property) do
    build_stubbed :interface_property, interface: interface
  end

  permissions :index?, :show? do
    it { is_expected.to permit nil }
  end

  permissions :create?, :update?, :destroy? do
    it { is_expected.not_to permit nil, interface_property }
    it { is_expected.not_to permit other_user, interface_property }
    it { is_expected.to permit current_user, interface_property }
    it { is_expected.to permit admin, interface_property }
  end
end
