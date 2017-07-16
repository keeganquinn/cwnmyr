# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'User profile page', :devise do
  let(:current_user) { create(:user) }
  let(:other_user) { create(:user) }

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'user sees own profile' do
    login_as(current_user, scope: :user)
    visit user_path(current_user)
    expect(page).to have_content current_user.name
  end

  # Scenario: User cannot see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I do not see their email address
  scenario "user cannot see another user's email address" do
    login_as(current_user, scope: :user)
    Capybara.current_session.driver.header 'Referer', root_path
    visit user_path(other_user)
    expect(page).not_to have_content other_user.email
  end
end
