describe 'Zone index page', type: :feature do
  it 'user is redirected' do
    visit zones_path
    expect(current_path).to eq(root_path)
  end
end
