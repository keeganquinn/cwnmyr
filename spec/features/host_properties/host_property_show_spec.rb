feature 'Host Property show page' do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:host) { create :host, node: node }
  let(:host_property) { create :host_property, host: host }

  before do
    login_as current_user
    visit host_property_path(host_property)
  end

  it { expect(page).to have_content host_property.key }

  it 'allows the host property to be edited' do
    click_link 'Edit'
    expect(page).to have_content 'Edit Host Property'
  end

  it 'allows the host property to be deleted' do
    click_link 'Delete'
    expect(page).to have_content host_property.host.name
  end
end
