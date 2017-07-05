include Warden::Test::Helpers
Warden.test_mode!

feature "Zone show page", :devise do
  let (:zone) { create :zone }
  let! (:node) { create :node, zone: zone }

  after(:each) do
    Warden.test_reset!
  end

  scenario "page is displayed", :js do
    visit zone_path(zone)
    expect(page).to have_content zone.name
    expect(page.response_headers['Content-Type']).to eq "text/html; charset=utf-8"
  end

  scenario "JSON data is returned" do
    visit zone_path(zone, format: :json)
    expect(page).to have_content zone.name
    expect(page.response_headers['Content-Type']).to eq "application/json; charset=utf-8"
  end

  scenario "KML data is returned" do
    visit zone_path(zone, format: :kml)
    expect(page.source).to match node.name
    expect(page.response_headers['Content-Type']).to eq "application/vnd.google-earth.kml+xml; charset=utf-8"
  end

  scenario "XML data is returned" do
    visit zone_path(zone, format: :xml)
    expect(page).to have_content zone.name
    expect(page.response_headers['Content-Type']).to eq "application/xml; charset=utf-8"
  end
end
