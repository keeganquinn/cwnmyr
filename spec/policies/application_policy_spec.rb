describe ApplicationPolicy do
  subject { described_class }

  permissions :index?, :create?, :update?, :destroy? do
    it { is_expected.not_to permit nil }
  end
end
