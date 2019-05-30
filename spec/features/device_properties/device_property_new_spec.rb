# frozen_string_literal: true

describe 'Device Property new page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:device) { create :device, node: node }

  before do
    login_as current_user
    visit new_device_property_path(device_id: device)
  end

  it { expect(page).to have_content 'New Device Property' }

  it 'allows a device property to be created' do
    fill_in 'device_property_key', with: 'speckey'
    fill_in 'device_property_value', with: 'specvalue'
    click_button 'Create'
    expect(page).to have_content 'speckey'
  end

  it 'shows an error if device property creation fails' do
    click_button 'Create'
    expect(page).to have_content 'errors prevented this device property'
  end
end
