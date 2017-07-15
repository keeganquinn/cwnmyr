# Feature: User delete
#   As a user
#   I want to delete my user profile
#   So I can close my account
feature 'User delete', :devise, :js do
  let(:current_user) { create(:user) }

  # Scenario: User can delete own account
  #   Given I am signed in
  #   When I delete my account
  #   Then I should see an account deleted message
  scenario 'user can delete own account' do
    login_as(current_user, scope: :user)
    visit edit_user_registration_path(current_user)
    click_button 'Cancel my account'
    expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end
end
