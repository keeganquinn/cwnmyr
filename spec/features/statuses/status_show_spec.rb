describe 'Status show page', type: :feature do
  let(:status) { create :status }

  it 'view the status page' do
    visit status_path(status)
    expect(page).to have_content status.name
  end
end
