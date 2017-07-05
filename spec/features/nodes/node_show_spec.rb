include Warden::Test::Helpers
Warden.test_mode!

feature "Node show page", :devise do
  let (:node) { create :node }

  after(:each) do
    Warden.test_reset!
  end

  scenario "page is displayed", :js do
    visit node_path(node)
    expect(page).to have_content node.name
    expect(page.response_headers['Content-Type']).to eq "text/html; charset=utf-8"
  end

  scenario "JSON data is returned" do
    visit node_path(node, format: :json)
    expect(page).to have_content node.name
    expect(page.response_headers['Content-Type']).to eq "application/json; charset=utf-8"
  end

  scenario "KML data is returned" do
    visit node_path(node, format: :kml)
    expect(page.source).to match node.name
    expect(page.response_headers['Content-Type']).to eq "application/vnd.google-earth.kml+xml; charset=utf-8"
  end

  scenario "XML data is returned" do
    visit node_path(node, format: :xml)
    expect(page.source).to match node.to_param
    expect(page.source).to match node.name
    expect(page.source).to match node.address
    expect(page.response_headers['Content-Type']).to eq "application/xml; charset=utf-8"
  end
end
