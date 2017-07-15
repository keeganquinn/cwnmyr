feature 'Interface Type show page' do
  let(:interface_type) { create :interface_type }

  scenario 'view the interface type page' do
    visit interface_type_path(interface_type)
    expect(page).to have_content interface_type.name
  end
end
