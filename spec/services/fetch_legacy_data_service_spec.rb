# frozen_string_literal: true

describe FetchLegacyDataService do
  subject(:service) { described_class }

  before { create :zone, default: true }

  xit 'returns node data when called' do
    expect(service.new.call).not_to be_empty
  end
end
