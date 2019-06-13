# frozen_string_literal: true

describe 'Contact show page', type: :feature do
  let(:current_user) { create :user }
  let(:contact) { create :contact, user: current_user }

  before do
    login_as current_user
    visit contact_path(contact)
  end

  it { expect(page).to have_content contact.name }

  it 'allows the contact to be edited' do
    click_link 'Edit'
    expect(page).to have_content 'Edit Contact'
  end

  it 'allows the contact to be deleted' do
    click_link 'Delete'
    expect(page).to have_content 'successfully deleted'
  end
end
