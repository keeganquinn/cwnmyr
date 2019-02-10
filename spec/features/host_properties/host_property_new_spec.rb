# frozen_string_literal: true

describe 'Host Property new page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:host) { create :host, node: node }

  before do
    login_as current_user
    visit new_host_property_path(host_id: host)
  end

  it { expect(page).to have_content 'New Host Property' }

  it 'allows a host property to be created' do
    fill_in 'host_property_key', with: 'speckey'
    fill_in 'host_property_value', with: 'specvalue'
    click_button 'Create'
    expect(page).to have_content 'speckey'
  end

  it 'shows an error if host property creation fails' do
    click_button 'Create'
    expect(page).to have_content 'errors prevented this host property'
  end
end
