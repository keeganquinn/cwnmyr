feature 'Node Link show page' do
  let(:node_link) { create :node_link }

  scenario 'view the node link page' do
    visit node_link_path(node_link)
    expect(page).to have_content node_link.name
  end
end
