# frozen_string_literal: true

describe 'Interface Type show page', type: :feature do
  let(:interface_type) { create :interface_type }

  it 'view the interface type page' do
    visit interface_type_path(interface_type)
    expect(page).to have_content interface_type.name
  end
end
