# frozen_string_literal: true

describe 'Device network diagram', type: :feature do
  let(:device) { create :device }
  let(:network) { create :network }

  it 'PNG data is returned' do
    create :interface, device: device, network: network,
                       address_ipv4: '10.11.23.2/24'
    create :interface, network: network, address_ipv4: '10.11.23.3/24'

    visit graph_device_path(device, format: :png)
    expect(page.response_headers['Content-Type']).to eq 'image/png'
  end

  it 'other requests are redirected' do
    visit graph_device_path(device)
    expect(page).to have_current_path graph_device_path(device, format: :png)
  end
end
