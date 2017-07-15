feature 'Node Link index page' do
  scenario 'user is redirected' do
    visit node_links_path
    expect(current_path).to eq(root_path)
  end
end
