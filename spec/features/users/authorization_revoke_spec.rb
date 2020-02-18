# frozen_string_literal: true

describe 'User Authorization revoke action', type: :feature do
  let(:current_user) { create :user }

  before do
    current_user.authorizations.create! provider: 'test', uid: 'test',
                                        confirmed_at: Time.now
    login_as current_user
    visit edit_user_registration_path
    click_link 'Revoke'
  end

  it 'shows a message indicating success' do
    expect(page).to have_content 'Authorization revoked.'
  end

  it 'destroys the authorization' do
    auth = current_user.authorizations.confirmed.find_by(provider: 'test')
    expect(auth).to be_nil
  end
end
