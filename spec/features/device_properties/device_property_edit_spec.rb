# frozen_string_literal: true

describe 'Device Property edit page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:device) { create :device, node: node }
  let(:device_property) { create :device_property, device: device }

  before do
    login_as current_user
    visit edit_device_property_path(device_property)
  end

  it { expect(page).to have_content 'Edit Device Property' }

  it 'allows a device property to be updated' do
    fill_in 'device_property_value', with: 'othervalue'
    click_button 'Update'
    expect(page).to have_content 'othervalue'
  end

  it 'shows an error if device property update fails' do
    fill_in 'device_property_value', with: ''
    click_button 'Update'
    expect(page).to have_content 'error prevented this device property'
  end
end
