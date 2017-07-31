describe HostPropertyPolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:node) { build_stubbed :node, user: current_user }
  let(:host) { build_stubbed :host, node: node }
  let(:host_property) { build_stubbed :host_property, host: host }

  permissions :show? do
    let(:host_property) { create :host_property }

    it { is_expected.to permit nil, host_property }
  end

  permissions :create?, :update?, :destroy? do
    it { is_expected.not_to permit nil, host_property }
    it { is_expected.not_to permit other_user, host_property }
    it { is_expected.to permit current_user, host_property }
    it { is_expected.to permit admin, host_property }
  end
end
