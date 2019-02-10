# frozen_string_literal: true

describe 'Host Type show page', type: :feature do
  let(:host_type) { create :host_type }

  it 'view the host type page' do
    visit host_type_path(host_type)
    expect(page).to have_content host_type.name
  end
end
