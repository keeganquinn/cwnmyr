feature 'Node Link new page' do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }

  before do
    login_as current_user
    visit new_node_link_path(node: node)
  end

  it { expect(page).to have_content 'New Link' }

  it 'allows a node link to be created' do
    fill_in 'node_link_name', with: 'Spec Link'
    fill_in 'node_link_url', with: 'https://quinn.tk/'
    click_button 'Create'
    expect(page).to have_content 'Spec Link'
  end

  it 'shows an error if node link creation fails' do
    click_button 'Create'
    expect(page).to have_content 'errors prevented this node link'
  end
end
