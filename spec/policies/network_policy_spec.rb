# frozen_string_literal: true

describe NetworkPolicy do
  subject { described_class }

  permissions :index? do
    it { is_expected.to permit nil }
  end

  permissions :show? do
    let(:network) { create :network }

    it { is_expected.to permit nil, network }
  end
end
