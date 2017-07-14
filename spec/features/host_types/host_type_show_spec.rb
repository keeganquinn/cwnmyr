feature 'Host Type show page' do
  let(:host_type) { create :host_type }

  scenario 'view the host type page' do
    visit host_type_path(host_type)
    expect(page).to have_content host_type.name
  end
end
