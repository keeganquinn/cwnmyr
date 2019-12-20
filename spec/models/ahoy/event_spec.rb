# frozen_string_literal: true

describe Ahoy::Event do
  subject(:ahoy_event) { build_stubbed :ahoy_event }

  it { is_expected.to belong_to(:visit) }
  it { is_expected.to belong_to(:user).optional }
end
