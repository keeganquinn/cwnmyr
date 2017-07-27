feature 'Host show page' do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:host) { create :host, node: node }

  before do
    login_as current_user
    visit host_path(host)
  end

  it { expect(page).to have_content host.name }

  it 'allows the host to be edited' do
    click_link 'Edit'
    expect(page).to have_content 'Edit Host'
  end

  it 'allows the host to be deleted' do
    click_link 'Delete'
    expect(page).to have_content host.node.name
  end
end
