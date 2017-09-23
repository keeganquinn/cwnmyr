describe 'Node show page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }

  before do
    login_as current_user
    visit node_path(node)
  end

  it { expect(page).to have_content node.name }

  it 'allows a link to be created' do
    fill_in 'node_link_name', with: 'Spec Link'
    fill_in 'node_link_url', with: 'http://example.com/spec'
    click_button 'node_link_create'
    expect(page).to have_content 'Spec Link'
  end

  it 'shows an error if link creation fails' do
    fill_in 'node_link_name', with: 'Invalid Link'
    fill_in 'node_link_url', with: 'Not a URL'
    click_button 'node_link_create'
    expect(page).to have_content 'error prevented this node link'
  end

  it 'allows the error to be corrected after a failed link create' do
    click_button 'node_link_create'
    fill_in 'node_link_name', with: 'Spec Link'
    fill_in 'node_link_url', with: 'http://example.com/spec'
    click_button 'node_link_create'
    expect(page).to have_content 'Spec Link'
  end

  it 'allows a host to be created' do
    fill_in 'host_name', with: 'spechost'
    click_button 'host_create'
    expect(page).to have_content 'spechost'
  end

  it 'shows an error if host creation fails' do
    click_button 'host_create'
    expect(page).to have_content 'error prevented this host'
  end

  it 'allows the error to be corrected after a failed host create' do
    click_button 'host_create'
    fill_in 'host_name', with: 'spechost'
    click_button 'host_create'
    expect(page).to have_content 'spechost'
  end

  it 'allows the node to be edited' do
    click_link 'Edit'
    expect(page).to have_content 'Edit Node'
  end

  it 'allows the node to be deleted' do
    click_link 'Delete'
    expect(page).to have_content node.zone.name
  end
end
