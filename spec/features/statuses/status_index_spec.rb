feature 'Status index page' do
  scenario 'view the status list' do
    visit statuses_path
    expect(page).to have_content 'Statuses'
  end
end
