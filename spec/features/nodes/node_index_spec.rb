feature 'Node index page' do
  scenario 'user is redirected' do
    visit nodes_path
    expect(current_path).to eq(root_path)
  end
end
