feature 'Node show page', :devise do
  let(:node) { create :node }

  scenario 'page is displayed', :js do
    visit node_path(node)
    expect(page).to have_content node.name
  end
end
