# frozen_string_literal: true

describe VerifyGeocodeService do
  subject(:service) { described_class }

  it 'reports nodes which were placed out of range' do
    node = create :node, address: '9150 Chesapeake Drive, San Diego, CA'
    expect(service.new.call[0]).to(
      eq "#{node.id} #{node.code}: location out of range: #{node.address}"
    )
  end
end
