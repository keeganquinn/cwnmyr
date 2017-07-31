describe NodeLinkPolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:node) { build_stubbed :node, user: current_user }
  let(:node_link) { build_stubbed :node_link, node: node }

  permissions :show? do
    let(:node_link) { create :node_link }

    it { is_expected.to permit nil, node_link }
  end

  permissions :new?, :create?, :edit?, :update?, :destroy? do
    it { is_expected.not_to permit nil, node_link }
    it { is_expected.not_to permit other_user, node_link }
    it { is_expected.to permit current_user, node_link }
    it { is_expected.to permit admin, node_link }
  end
end
