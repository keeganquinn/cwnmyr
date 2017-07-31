describe HostTypePolicy do
  subject { described_class }

  permissions :index? do
    it { is_expected.to permit nil }
  end

  permissions :show? do
    let(:host_type) { create :host_type }

    it { is_expected.to permit nil, host_type }
  end
end
