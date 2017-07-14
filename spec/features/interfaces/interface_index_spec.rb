feature 'Interface index page' do
  scenario 'user is redirected' do
    visit interfaces_path
    expect(current_path).to eq(root_path)
  end
end
