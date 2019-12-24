# frozen_string_literal: true

describe AuthorizedHost do
  subject(:authorized_host) { build_stubbed :authorized_host }

  it { is_expected.to belong_to(:device) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:address_ipv4) }
  it { is_expected.to respond_to(:address_ipv6) }
  it { is_expected.to respond_to(:address_mac) }
  it { is_expected.to respond_to(:comment) }
end
