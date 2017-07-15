feature 'Users admin interface', :devise do
  let(:user) { build :user }
  let(:admin) { build :user, :admin }

  describe 'unauthenticated user attempts access' do
    before { visit admin_users_path }

    it { expect(current_path).to eq(new_user_session_path) }
    it { expect(page).to have_content 'You need to sign in' }
  end

  describe 'normal user attempts access' do
    before do
      login_as user
      visit admin_users_path
    end

    it { expect(current_path).to eq(new_user_session_path) }
    it { expect(page).to have_content 'Access denied' }
  end

  describe 'admin user attempts access' do
    before do
      login_as admin
      visit admin_users_path
    end

    it { expect(current_path).to eq(admin_users_path) }
    it { expect(page).to have_content 'Users' }
  end
end
