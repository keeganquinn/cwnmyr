feature 'Host edit page' do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:host) { create :host, node: node }

  before do
    login_as current_user
    visit edit_host_path(host)
  end

  it { expect(page).to have_content 'Edit Host' }

  it 'allows a host to be updated' do
    fill_in 'host_name', with: 'newname'
    click_button 'Update'
    expect(page).to have_content 'newname'
  end

  it 'shows an error if host update fails' do
    fill_in 'host_name', with: ''
    click_button 'Update'
    expect(page).to have_content 'error prevented this host'
  end
end
