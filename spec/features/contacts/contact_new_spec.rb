# frozen_string_literal: true

describe 'Contact new page', type: :feature do
  let(:current_user) { create :user }

  before do
    login_as current_user
    visit new_contact_path
  end

  it { expect(page).to have_content 'New Contact' }

  it 'allows a contact to be created' do
    fill_in 'contact_name', with: 'Spec Contact'
    click_button 'Create'
    expect(page).to have_content 'Spec Contact'
  end

  it 'shows an error if contact creation fails' do
    click_button 'Create'
    expect(page).to have_content 'errors prevented this contact'
  end
end
