# frozen_string_literal: true

describe BuildProvider do
  subject(:build_provider) { build_stubbed(:build_provider) }

  it { is_expected.to have_many(:device_builds) }
  it { is_expected.to have_many(:device_types) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:url) }
end
