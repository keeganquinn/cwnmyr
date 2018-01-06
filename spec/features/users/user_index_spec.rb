# Feature: User index page
#   As a user
#   I want to see a list of users
#   So I can see who has registered
describe 'User index page', :devise, type: :feature do
  # Scenario: User listed on index page
  #   Given I am signed in
  #   When I visit the user index page
  #   Then I see my own name
  it 'user sees own name' do
    user = FactoryBot.create(:user, :admin)
    login_as user
    visit users_path
    expect(page).to have_content user.name
  end
end
