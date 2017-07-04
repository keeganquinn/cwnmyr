include Warden::Test::Helpers
Warden.test_mode!

feature "Node show page", :devise do
  let (:node) { create :node }

  after(:each) do
    Warden.test_reset!
  end

  scenario "page is displayed" do
    visit url_for(node)
    expect(page).to have_content node.name
    expect(page.response_headers['Content-Type']).to eq "text/html; charset=utf-8"
  end

  scenario "JSON data is returned" do
    visit polymorphic_url(node, format: :json)
    expect(page).to have_content node.name
    expect(page.response_headers['Content-Type']).to eq "application/json; charset=utf-8"
  end

  scenario "XML data is returned" do
    visit polymorphic_url(node, format: :xml)
    expect(page).to have_content node.name
    expect(page.response_headers['Content-Type']).to eq "application/xml; charset=utf-8"
  end
end
