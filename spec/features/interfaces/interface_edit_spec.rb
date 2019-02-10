# frozen_string_literal: true

describe 'Interface edit page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:host) { create :host, node: node }
  let(:interface) { create :interface, host: host }

  before do
    login_as current_user
    visit edit_interface_path(interface)
  end

  it { expect(page).to have_content 'Edit Interface' }

  it 'allows an interface to be updated' do
    fill_in 'interface_code', with: 'someother'
    click_button 'Update'
    expect(page).to have_content 'someother'
  end

  it 'shows an error if interface update fails' do
    fill_in 'interface_code', with: ''
    fill_in 'interface_name', with: ''
    click_button 'Update'
    expect(page).to have_content 'error prevented this interface'
  end
end
