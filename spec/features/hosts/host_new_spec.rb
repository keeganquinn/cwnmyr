feature 'Host new page' do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }

  before do
    login_as current_user
    visit new_host_path(node: node)
  end

  it { expect(page).to have_content 'New Host' }

  it 'allows a host to be created' do
    fill_in 'host_name', with: 'spechost'
    click_button 'Create'
    expect(page).to have_content 'spechost'
  end

  it 'shows an error if host creation fails' do
    click_button 'Create'
    expect(page).to have_content 'error prevented this host'
  end
end
