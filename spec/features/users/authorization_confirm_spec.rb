# frozen_string_literal: true

describe 'User Authorization confirm action', type: :feature do
  let(:current_user) { create :user }

  before do
    current_user.authorizations.create! provider: 'test', uid: 'test'
    login_as current_user
    visit edit_user_registration_path
    click_link 'Confirm'
  end

  it 'shows a message indicating success' do
    expect(page).to have_content 'Authorization confirmed.'
  end

  it 'sets the confirmed_at timestamp' do
    auth = current_user.authorizations.confirmed.find_by(provider: 'test')
    expect(auth).not_to be_nil
  end
end
