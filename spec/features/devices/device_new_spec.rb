# frozen_string_literal: true

describe 'Device new page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }

  before do
    login_as current_user
    visit new_device_path(node: node)
  end

  it { expect(page).to have_content 'New Device' }

  it 'allows a device to be created' do
    fill_in 'device_name', with: 'specdevice'
    click_button 'Create'
    expect(page).to have_content 'specdevice'
  end

  it 'shows an error if device creation fails' do
    click_button 'Create'
    expect(page).to have_content "Hostname can't be blank"
  end
end
