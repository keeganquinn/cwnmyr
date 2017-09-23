describe 'Node Link show page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:node_link) { create :node_link, node: node }

  before do
    login_as current_user
    visit node_link_path(node_link)
  end

  it { expect(page).to have_content node_link.name }

  it 'allows the node link to be edited' do
    click_link 'Edit'
    expect(page).to have_content 'Edit Node Link'
  end

  it 'allows the node link to be deleted' do
    click_link 'Delete'
    expect(page).to have_content node_link.node.name
  end
end
