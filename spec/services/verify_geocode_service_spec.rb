# frozen_string_literal: true

DISTANT_ADDRESS = '9150 Chesapeake Drive, San Diego, CA'
LOCAL_ADDRESS = '727 SE Grand Ave, Portland, OR 97214'

describe VerifyGeocodeService do
  subject(:service) { described_class }

  let(:zone) { create :zone, address: LOCAL_ADDRESS }

  it 'reports nodes which were placed out of range' do
    node = create :node, zone: zone, address: DISTANT_ADDRESS
    expect(service.new.call[0]).to(
      eq "#{node.id} #{node.code}: location out of range: #{node.address}"
    )
  end
end
