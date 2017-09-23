describe 'User Link show page', type: :feature do
  let(:current_user) { create :user }
  let(:user_link) { create :user_link, user: current_user }

  before do
    login_as current_user
    visit user_link_path(user_link)
  end

  it { expect(page).to have_content user_link.name }

  it 'allows the user link to be edited' do
    click_link 'Edit'
    expect(page).to have_content 'Edit User Link'
  end

  it 'allows the user link to be deleted' do
    click_link 'Delete'
    expect(page).to have_content user_link.user.name
  end
end
