feature 'Host Type index action' do
  scenario 'view the host type list' do
    visit host_types_path
    expect(page).to have_content 'Host Types'
  end
end
