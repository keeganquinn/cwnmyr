feature 'Host show page' do
  let(:host) { create :host }

  scenario 'view the host page' do
    visit host_path(host)
    expect(page).to have_content host.name
  end
end
