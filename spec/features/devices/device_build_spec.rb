# frozen_string_literal: true

describe 'Device build feature', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }

  before do
    login_as current_user
    visit device_path(device)
    click_link 'Start New Build'
  end

  describe 'build started' do
    let(:build_provider) { create :build_provider, active: true }
    let(:device_type) { create :device_type, build_provider: build_provider }
    let(:device) { create :device, device_type: device_type, node: node }

    it { expect(page).to have_content 'Build started.' }
  end

  describe 'build not available' do
    let(:build_provider) { create :build_provider, active: true, mode: 'fail' }
    let(:device_type) { create :device_type, build_provider: build_provider }
    let(:device) { create :device, device_type: device_type, node: node }

    it { expect(page).to have_content 'Build not available.' }
  end
end
