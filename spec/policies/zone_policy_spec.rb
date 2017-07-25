describe ZonePolicy do
  subject { described_class }

  permissions :index?, :show?, :conf? do
    it { is_expected.to permit nil }
  end
end
