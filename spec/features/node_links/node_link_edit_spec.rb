feature 'Node Link edit page' do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:node_link) { create :node_link, node: node }

  before do
    login_as current_user
    visit edit_node_link_path(node_link)
  end

  it { expect(page).to have_content 'Edit Link' }

  it 'allows a node link to be updated' do
    fill_in 'node_link_name', with: 'A Different Name'
    click_button 'Update'
    expect(page).to have_content 'A Different Name'
  end

  it 'shows an error if node link update fails' do
    fill_in 'node_link_name', with: ''
    click_button 'Update'
    expect(page).to have_content 'error prevented this link'
  end
end
