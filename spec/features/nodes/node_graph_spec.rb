# frozen_string_literal: true

describe 'Node network diagram', type: :feature do
  let(:node) { create :node }
  let(:host) { create :host, node: node }
  let(:network) { create :interface_type, allow_neighbors: true }

  it 'PNG data is returned' do
    create :interface,
           host: host, interface_type: network, address_ipv4: '10.11.23.2/24'
    create :interface, interface_type: network, address_ipv4: '10.11.23.3/24'

    visit graph_node_path(node, format: :png)
    expect(page.response_headers['Content-Type']).to eq 'image/png'
  end

  it 'other requests are redirected' do
    visit graph_node_path(node)
    expect(page).to have_current_path graph_node_path(node, format: :png)
  end
end
