describe StatusPolicy do
  subject { described_class }

  permissions :index?, :show? do
    it { is_expected.to permit nil }
  end
end
