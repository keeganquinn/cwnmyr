# frozen_string_literal: true

describe 'Hosts admin interface', type: :feature do
  let(:user) { build :user }
  let(:admin) { build :user, :admin }

  describe 'unauthenticated user attempts access' do
    before { visit admin_hosts_path }

    it { expect(page).to have_current_path(new_user_session_path) }
    it { expect(page).to have_content 'You need to sign in' }
  end

  describe 'normal user attempts access' do
    before do
      login_as user
      visit admin_hosts_path
    end

    it { expect(page).to have_current_path(new_user_session_path) }
    it { expect(page).to have_content 'Access denied' }
  end

  describe 'admin user attempts access' do
    before do
      login_as admin
      visit admin_hosts_path
    end

    it { expect(page).to have_current_path(admin_hosts_path) }
    it { expect(page).to have_content 'Hosts' }
  end
end
