# frozen_string_literal: true

describe FetchLegacyDataService do
  subject(:service) { described_class }

  before { create :zone, default: true }

  it 'is able to fetch node data' do
    expect(service.new.fetch).not_to be_empty
  end

  it 'returns node data when called' do
    expect(service.new.call).not_to be_empty
  end
end
