# frozen_string_literal: true

describe 'Network index page', type: :feature do
  it 'view the network list' do
    visit networks_path
    expect(page).to have_content 'Networks'
  end
end
