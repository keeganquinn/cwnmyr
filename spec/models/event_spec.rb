# frozen_string_literal: true

describe Event do
  subject(:event) { build_stubbed(:event) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:group) }
end
