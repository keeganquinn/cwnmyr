describe 'Interface new page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:host) { create :host, node: node }

  before do
    login_as current_user
    visit new_interface_path(host_id: host)
  end

  it { expect(page).to have_content 'New Interface' }

  it 'allows an interface to be created' do
    fill_in 'interface_code', with: 'spec'
    click_button 'Create'
    expect(page).to have_content 'spec'
  end

  it 'shows an error if interface creation fails' do
    click_button 'Create'
    expect(page).to have_content 'error prevented this interface'
  end
end
