feature 'Host index page' do
  scenario 'user is redirected' do
    visit hosts_path
    expect(current_path).to eq(root_path)
  end
end
