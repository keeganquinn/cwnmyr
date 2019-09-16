# frozen_string_literal: true

describe 'Node show page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, :with_image, user: current_user }

  before do
    login_as current_user
    visit node_path(node)
  end

  it { expect(page).to have_content node.name }

  it 'allows a device to be created' do
    click_link 'New Device'
    expect(page).to have_content 'New Device'
  end

  it 'allows the node to be edited' do
    click_link 'Edit'
    expect(page).to have_content 'Edit Node'
  end

  it 'allows the node to be deleted' do
    click_link 'Delete'
    expect(page).to have_content 'successfully deleted'
  end

  it 'allows a node to be referenced by code' do
    visit node_path(node.code)
    expect(page).to have_content node.name
  end

  it 'indicates when a node is not found' do
    visit node_path('abcde')
    expect(page).to have_content 'Not found'
  end
end
