# Feature: User edit
#   As a user
#   I want to edit my user profile
#   So I can change my email address
describe 'User edit', :devise, type: :feature do
  let(:current_user) { create(:user) }
  let(:other_user) { create(:user) }

  before { login_as current_user }

  # Scenario: User changes email address
  #   Given I am signed in
  #   When I change my email address
  #   Then I see an account updated message
  describe 'user changes email address' do
    before do
      visit edit_user_registration_path(current_user)
      fill_in 'Email', with: 'newemail@example.com'
      fill_in 'Current password', with: current_user.password
      click_button 'Update'
    end

    it 'displays the correct message' do
      txts = [I18n.t('devise.registrations.updated'),
              I18n.t('devise.registrations.update_needs_confirmation')]
      expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
    end
  end

  # Scenario: User cannot edit another user's profile
  #   Given I am signed in
  #   When I try to edit another user's profile
  #   Then I see my own 'edit profile' page
  describe "user cannot cannot edit another user's profile", :me do
    subject { page }

    before { visit edit_user_registration_path(other_user) }

    it { is_expected.to have_content 'Edit User' }
    it { is_expected.to have_field('Email', with: current_user.email) }
  end
end
