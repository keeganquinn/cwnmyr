# frozen_string_literal: true

describe 'User Link new page', type: :feature do
  let(:current_user) { create :user }

  before do
    login_as current_user
    visit new_user_link_path(user: current_user)
  end

  it { expect(page).to have_content 'New User Link' }

  it 'allows a user link to be created' do
    fill_in 'user_link_name', with: 'Spec Link'
    fill_in 'user_link_url', with: 'https://quinn.tk/'
    click_button 'Create'
    expect(page).to have_content 'Spec Link'
  end

  it 'shows an error if user link creation fails' do
    click_button 'Create'
    expect(page).to have_content 'errors prevented this user link'
  end
end
