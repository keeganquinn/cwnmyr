# frozen_string_literal: true

describe 'Device Type show page', type: :feature do
  let(:device_type) { create :device_type }

  it 'view the device type page' do
    visit device_type_path(device_type)
    expect(page).to have_content device_type.name
  end
end
