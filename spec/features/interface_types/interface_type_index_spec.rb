feature 'Interface Type index action' do
  scenario 'view the interface type list' do
    visit interface_types_path
    expect(page).to have_content 'Interface Types'
  end
end
