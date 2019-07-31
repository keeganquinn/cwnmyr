# frozen_string_literal: true

describe DeviceBuild do
  subject(:device_build) { build_stubbed(:device_build) }

  it { is_expected.to belong_to(:build_provider) }
  it { is_expected.to belong_to(:device) }
  it { is_expected.to belong_to(:device_type) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:url) }
end
