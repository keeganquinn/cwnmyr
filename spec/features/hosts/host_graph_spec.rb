# frozen_string_literal: true

describe 'Host network diagram', type: :feature do
  let(:host) { create :host }
  let(:network) { create :interface_type }

  it 'PNG data is returned' do
    create :interface,
           host: host, interface_type: network, address_ipv4: '10.11.23.2/24'
    create :interface, interface_type: network, address_ipv4: '10.11.23.3/24'

    visit graph_host_path(host, format: :png)
    expect(page.response_headers['Content-Type']).to eq 'image/png'
  end

  it 'other requests are redirected' do
    visit graph_host_path(host)
    expect(page).to have_current_path graph_host_path(host, format: :png)
  end
end
