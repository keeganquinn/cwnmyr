include Warden::Test::Helpers
Warden.test_mode!

feature "Zone markers", :devise do
  let (:zone) { create :zone }
  let! (:node) { create :node, zone: zone }

  after(:each) do
    Warden.test_reset!
  end

  scenario "browser request" do
    visit markers_zone_path(zone)
    expect(current_path).to eq(zone_path(zone))
  end

  scenario "markers in JSON format" do
    visit markers_zone_path(zone, format: :json)
    expect(page).to have_content node.name
    expect(page.response_headers['Content-Type']).to eq "application/json; charset=utf-8"
  end

  scenario "markers in KML format" do
    visit markers_zone_path(zone, format: :kml)
    expect(page).to have_content zone.name
    expect(page.response_headers['Content-Type']).to eq "application/vnd.google-earth.kml+xml; charset=utf-8"
    expect(page.response_headers['Content-Disposition']).to match "^attachment; filename=\".*\"$"
  end
end
