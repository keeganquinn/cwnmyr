# frozen_string_literal: true

describe 'Device Type index page', type: :feature do
  it 'view the device type list' do
    visit device_types_path
    expect(page).to have_content 'Device Types'
  end
end
