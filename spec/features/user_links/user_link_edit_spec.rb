feature 'User Link edit page' do
  let(:current_user) { create :user }
  let(:user_link) { create :user_link, user: current_user }

  before do
    login_as current_user
    visit edit_user_link_path(user_link)
  end

  it { expect(page).to have_content 'Edit Link' }

  it 'allows a user link to be updated' do
    fill_in 'user_link_name', with: 'A Different Name'
    click_button 'Update'
    expect(page).to have_content 'A Different Name'
  end

  it 'shows an error if user link update fails' do
    fill_in 'user_link_name', with: ''
    click_button 'Update'
    expect(page).to have_content 'error prevented this user link'
  end
end
