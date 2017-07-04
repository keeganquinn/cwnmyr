include Warden::Test::Helpers
Warden.test_mode!

feature "Zone show page", :devise do
  let (:zone) { create :zone }

  after(:each) do
    Warden.test_reset!
  end

  scenario "page is displayed" do
    visit url_for(zone)
    expect(page).to have_content zone.name
    expect(page.response_headers['Content-Type']).to eq "text/html; charset=utf-8"
  end

  scenario "JSON data is returned" do
    visit polymorphic_url(zone, format: :json)
    expect(page).to have_content zone.name
    expect(page.response_headers['Content-Type']).to eq "application/json; charset=utf-8"
  end

  scenario "XML data is returned" do
    skip "not yet implemented"
    visit polymorphic_url(zone, format: :xml)
    expect(page).to have_content zone.name
    expect(page.response_headers['Content-Type']).to eq "application/xml; charset=utf-8"
  end
end
