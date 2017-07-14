feature 'Host Property index page' do
  scenario 'user is redirected' do
    visit host_properties_path
    expect(current_path).to eq(root_path)
  end
end
