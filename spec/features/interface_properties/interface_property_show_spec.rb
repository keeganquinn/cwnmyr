# frozen_string_literal: true

describe 'Interface Property show page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:device) { create :device, node: node }
  let(:interface) { create :interface, device: device }
  let(:interface_property) { create :interface_property, interface: interface }

  before do
    login_as current_user
    visit interface_property_path(interface_property)
  end

  it { expect(page).to have_content interface_property.key }

  it 'allows the interface property to be edited' do
    click_link 'Edit'
    expect(page).to have_content 'Edit Interface Property'
  end

  it 'allows the interface property to be deleted' do
    click_link 'Delete'
    expect(page).to have_content interface_property.interface.name
  end
end
