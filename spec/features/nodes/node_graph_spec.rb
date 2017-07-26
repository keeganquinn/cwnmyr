feature 'Node network diagram' do
  let(:node) { create :node }
  let(:host) { create :host, node: node }
  let(:network) { create :interface_type }

  scenario 'PNG data is returned' do
    create :interface,
           host: host, interface_type: network, address_ipv4: '10.11.23.2/24'
    create :interface, interface_type: network, address_ipv4: '10.11.23.3/24'

    visit graph_node_path(node, format: :png)
    expect(page.response_headers['Content-Type']).to eq 'image/png'
  end

  scenario 'other requests are redirected' do
    visit graph_node_path(node)
    expect(current_path).to eq graph_node_path(node, format: :png)
  end
end
