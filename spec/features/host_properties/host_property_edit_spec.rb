# frozen_string_literal: true

describe 'Host Property edit page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:host) { create :host, node: node }
  let(:host_property) { create :host_property, host: host }

  before do
    login_as current_user
    visit edit_host_property_path(host_property)
  end

  it { expect(page).to have_content 'Edit Host Property' }

  it 'allows a host property to be updated' do
    fill_in 'host_property_value', with: 'othervalue'
    click_button 'Update'
    expect(page).to have_content 'othervalue'
  end

  it 'shows an error if host property update fails' do
    fill_in 'host_property_value', with: ''
    click_button 'Update'
    expect(page).to have_content 'error prevented this host property'
  end
end
