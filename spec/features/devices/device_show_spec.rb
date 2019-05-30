# frozen_string_literal: true

describe 'Device show page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:device) { create :device, node: node }

  before do
    login_as current_user
    visit device_path(device)
  end

  it { expect(page).to have_content device.name }

  it 'allows the device to be edited' do
    click_link 'Edit'
    expect(page).to have_content 'Edit Device'
  end

  it 'allows the device to be deleted' do
    click_link 'Delete'
    expect(page).to have_content device.node.name
  end
end
