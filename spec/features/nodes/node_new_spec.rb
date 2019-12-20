# frozen_string_literal: true

describe 'Node new page', type: :feature do
  let(:current_user) { create :user }

  before do
    create :zone, default: true
    create :status, name: 'Active'
    login_as current_user
    visit new_node_path
  end

  it { expect(page).to have_content 'New Node' }

  it 'allows a node to be created' do
    fill_in 'node_name', with: 'Spec Node'
    select 'Active', from: 'node_status_id'
    click_button 'Create'
    expect(page).to have_content 'Spec Node'
  end

  it 'shows an error if node creation fails' do
    click_button 'Create'
    expect(page).to have_content "Name can't be blank"
  end
end
