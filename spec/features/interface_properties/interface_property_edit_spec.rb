describe 'Interface Property edit page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:host) { create :host, node: node }
  let(:interface) { create :interface, host: host }
  let(:interface_property) { create :interface_property, interface: interface }

  before do
    login_as current_user
    visit edit_interface_property_path(interface_property)
  end

  it { expect(page).to have_content 'Edit Interface Property' }

  it 'allows an interface property to be updated' do
    fill_in 'interface_property_value', with: 'othervalue'
    click_button 'Update'
    expect(page).to have_content 'othervalue'
  end

  it 'shows an error if interface property update fails' do
    fill_in 'interface_property_value', with: ''
    click_button 'Update'
    expect(page).to have_content 'error prevented this interface property'
  end
end
