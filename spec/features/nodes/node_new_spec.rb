# frozen_string_literal: true

describe 'Node new page', type: :feature do
  let(:current_user) { create :user }
  let(:zone) { create :zone }

  before do
    create :status
    login_as current_user
    visit new_node_path(zone: zone)
  end

  it { expect(page).to have_content 'New Node' }

  it 'allows a node to be created' do
    fill_in 'node_name', with: 'Spec Node'
    click_button 'Create'
    expect(page).to have_content 'Spec Node'
  end

  it 'shows an error if node creation fails' do
    click_button 'Create'
    expect(page).to have_content 'errors prevented this node'
  end
end
