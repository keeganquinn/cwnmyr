# frozen_string_literal: true

# Feature: User delete
#   As a user
#   I want to delete my user profile
#   So I can close my account
describe 'User delete', :devise, type: :feature do
  let(:current_user) { create(:user) }

  # Scenario: User can delete own account
  #   Given I am signed in
  #   When I delete my account
  #   Then I should see an account deleted message
  it 'user can delete own account' do
    login_as current_user
    visit edit_user_registration_path(current_user)
    click_button 'Cancel Account'
    expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end
end
