describe UserLinkPolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:user_link) { build_stubbed :user_link, user: current_user }

  permissions :index?, :show? do
    it { is_expected.to permit nil }
  end

  permissions :create?, :update?, :destroy? do
    it { is_expected.not_to permit nil, user_link }
    it { is_expected.not_to permit other_user, user_link }
    it { is_expected.to permit current_user, user_link }
    it { is_expected.to permit admin, user_link }
  end
end
