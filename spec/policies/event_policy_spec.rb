# frozen_string_literal: true

describe EventPolicy do
  subject { described_class }

  permissions :index? do
    it { is_expected.to permit nil, nil }
  end
end
