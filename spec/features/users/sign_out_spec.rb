# Feature: Sign out
#   As a user
#   I want to sign out
#   So I can protect my account from unauthorized access
describe 'Sign out', :devise, type: :feature do
  let(:current_user) { create(:user) }

  # Scenario: User signs out successfully
  #   Given I am signed in
  #   When I sign out
  #   Then I see a signed out message
  it 'user signs out successfully' do
    login_as current_user
    visit root_path
    click_link 'Sign Out'
    expect(page).to have_content I18n.t 'devise.sessions.signed_out'
  end
end
