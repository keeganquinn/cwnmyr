include Warden::Test::Helpers
Warden.test_mode!

feature "Zone index page", :devise do
  let! (:zone) { create :zone }

  after(:each) do
    Warden.test_reset!
  end

  scenario "user is redirected" do
    visit zones_path
    expect(current_path).to eq(root_path)
  end

  scenario "JSON data is returned" do
    visit zones_path(format: :json)
    expect(page).to have_content zone.name
    expect(page.response_headers['Content-Type']).to eq "application/json; charset=utf-8"
  end

  scenario "XML data is returned" do
    visit zones_path(format: :xml)
    expect(page).to have_content zone.name
    expect(page.response_headers['Content-Type']).to eq "application/xml; charset=utf-8"
  end
end
