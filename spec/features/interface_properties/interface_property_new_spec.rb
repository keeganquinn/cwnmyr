# frozen_string_literal: true

describe 'Interface Property new page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:device) { create :device, node: node }
  let(:interface) { create :interface, device: device }

  before do
    login_as current_user
    visit new_interface_property_path(interface: interface)
  end

  it { expect(page).to have_content 'New Interface Property' }

  it 'allows an interface property to be created' do
    fill_in 'interface_property_key', with: 'speckey'
    fill_in 'interface_property_value', with: 'specvalue'
    click_button 'Create'
    expect(page).to have_content 'speckey'
  end

  it 'shows an error if interface property creation fails' do
    click_button 'Create'
    expect(page).to have_content 'errors prevented this interface property'
  end
end
