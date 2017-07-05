# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do
  let! (:node) { create :node }

  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "Welcome"
  scenario 'visit the home page', :js do
    visit root_path
    expect(page).to have_content('Looking for a node?')
    expect(page).to have_selector("#map[data-center='disco']")
  end

  scenario 'retrieve map markers' do
    visit root_path(format: :json)
    expect(page).to have_content(node.name)
    expect(page.response_headers['Content-Type']).to eq "application/json; charset=utf-8"
  end

  scenario 'download the KML data' do
    visit root_path(format: :kml)
    expect(page.source).to match 'cwnmyr'
    expect(page.source).to match node.name
    expect(page.response_headers['Content-Type']).to eq "application/vnd.google-earth.kml+xml; charset=utf-8"
  end
end
