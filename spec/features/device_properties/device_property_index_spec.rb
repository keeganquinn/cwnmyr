# frozen_string_literal: true

describe 'DeviceProperty index page', type: :feature do
  before { visit device_properties_path }

  it { expect(page).to have_content 'Join Us' }
end
