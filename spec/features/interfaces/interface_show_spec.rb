feature 'Interface show page' do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:host) { create :host, node: node }
  let(:interface) { create :interface, host: host }

  before do
    login_as current_user
    visit interface_path(interface)
  end

  it { expect(page).to have_content interface.code }

  it 'allows the interface to be edited' do
    print page.body
    click_link 'Edit'
    expect(page).to have_content 'Edit Interface'
  end

  it 'allows the interface to be deleted' do
    click_link 'Delete'
    expect(page).to have_content interface.host.name
  end
end
