feature 'Status show page' do
  let(:status) { create :status }

  scenario 'view the status page' do
    visit status_path(status)
    expect(page).to have_content status.name
  end
end
