# frozen_string_literal: true

describe Ahoy::Visit do
  subject(:ahoy_visit) { build_stubbed :ahoy_visit }

  it { is_expected.to belong_to(:user) }
end
