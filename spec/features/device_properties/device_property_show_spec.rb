# frozen_string_literal: true

describe 'Device Property show page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:device) { create :device, node: node }
  let(:device_property) { create :device_property, device: device }

  before do
    login_as current_user
    visit device_property_path(device_property)
  end

  it { expect(page).to have_content device_property.device.name }
end
