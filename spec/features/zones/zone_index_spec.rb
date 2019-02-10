# frozen_string_literal: true

describe 'Zone index page', type: :feature do
  it 'user is redirected' do
    visit zones_path
    expect(page).to have_current_path(root_path)
  end
end
