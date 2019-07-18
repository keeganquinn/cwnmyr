# frozen_string_literal: true

describe 'Device edit page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:device) { create :device, node: node }

  before do
    login_as current_user
    visit edit_device_path(device)
  end

  it { expect(page).to have_content 'Edit Device' }

  it 'allows a device to be updated' do
    fill_in 'device_name', with: 'newname'
    click_button 'Update'
    expect(page).to have_content 'newname'
  end

  it 'shows an error if device update fails' do
    fill_in 'device_name', with: ''
    click_button 'Update'
    expect(page).to have_content "Hostname can't be blank"
  end
end
