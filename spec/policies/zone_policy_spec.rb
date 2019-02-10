# frozen_string_literal: true

describe ZonePolicy do
  subject { described_class }

  permissions :index? do
    it { is_expected.to permit nil }
  end

  permissions :show?, :conf? do
    let(:zone) { create :zone }

    it { is_expected.to permit nil, zone }
  end
end
