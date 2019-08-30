# frozen_string_literal: true

describe 'User edit', :devise, type: :feature do
  subject { page }

  let(:current_user) { create(:user) }
  let(:other_user) { create(:user) }

  before { login_as current_user }

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

  describe 'user updates profile' do
    before do
      visit edit_user_registration_path(current_user)
      fill_in 'Body', with: 'Information about spec user!'
      click_button 'Update Profile'
    end

    it { is_expected.to have_current_path user_path(current_user) }
    it { is_expected.to have_content 'Information about spec user!' }
  end

  describe "user cannot cannot edit another user's profile", :me do
    before { visit edit_user_registration_path(other_user) }

    it { is_expected.to have_content 'Account Settings' }
    it { is_expected.to have_field('Email', with: current_user.email) }
  end

  describe 'user edit by own id redirects' do
    before { visit edit_user_path(current_user) }

    it { is_expected.to have_current_path edit_user_registration_path }
  end

  describe 'user edit by other id redirects' do
    before { visit edit_user_path(other_user) }

    it { is_expected.to have_current_path root_path }
  end
end
