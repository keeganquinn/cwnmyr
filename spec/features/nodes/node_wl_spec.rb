include Warden::Test::Helpers
Warden.test_mode!

feature "Node WL output", :devise do
  let (:node) { create :node }

  after(:each) do
    Warden.test_reset!
  end

  scenario "XML data is returned" do
    visit wl_node_path(node, format: :xml)
    expect(page).to have_content node.address
    expect(page.response_headers['Content-Type']).to eq "application/xml; charset=utf-8"
  end
end
