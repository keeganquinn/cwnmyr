# frozen_string_literal: true

describe 'Contact edit page', type: :feature do
  let(:current_user) { create :user }
  let(:contact) { create :contact, user: current_user }

  before do
    login_as current_user
    visit edit_contact_path(contact)
  end

  it { expect(page).to have_content 'Edit Contact' }

  it 'allows a contact to be updated' do
    fill_in 'contact_notes', with: 'Some text about the contact!'
    click_button 'Update'
    expect(page).to have_content 'Some text about the contact!'
  end

  it 'shows an error if node update fails' do
    fill_in 'contact_name', with: ''
    click_button 'Update'
    expect(page).to have_content "Name can't be blank"
  end
end
