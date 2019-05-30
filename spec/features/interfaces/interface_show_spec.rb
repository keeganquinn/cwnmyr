# frozen_string_literal: true

describe 'Interface show page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:device) { create :device, node: node }
  let(:interface) { create :interface, device: device }

  before do
    login_as current_user
    visit interface_path(interface)
  end

  it { expect(page).to have_content interface.code }

  it 'allows the interface to be edited' do
    click_link 'Edit'
    expect(page).to have_content 'Edit Interface'
  end

  it 'allows the interface to be deleted' do
    click_link 'Delete'
    expect(page).to have_content interface.device.name
  end
end
