feature 'Interface Property index page' do
  scenario 'user is redirected' do
    visit interface_properties_path
    expect(current_path).to eq(root_path)
  end
end
