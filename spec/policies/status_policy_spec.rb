describe StatusPolicy do
  subject { described_class }

  permissions :index? do
    it { is_expected.to permit nil }
  end

  permissions :show? do
    let(:status) { create :status }

    it { is_expected.to permit nil, status }
  end
end
