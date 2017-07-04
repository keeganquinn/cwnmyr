include Warden::Test::Helpers
Warden.test_mode!

feature "Node markers", :devise do
  let (:node) { create :node }

  after(:each) do
    Warden.test_reset!
  end

  scenario "browser request" do
    visit markers_node_path(node)
    expect(current_path).to eq(node_path(node))
  end

  scenario "markers in JSON format" do
    visit markers_node_path(node, format: :json)
    expect(page).to have_content node.name
    expect(page.response_headers['Content-Type']).to eq "application/json; charset=utf-8"
  end

  scenario "markers in KML format" do
    visit markers_node_path(node, format: :kml)
    expect(page).to have_content node.name
    expect(page.response_headers['Content-Type']).to eq "application/vnd.google-earth.kml+xml; charset=utf-8"
    expect(page.response_headers['Content-Disposition']).to match "^attachment; filename=\".*\"$"
  end
end
