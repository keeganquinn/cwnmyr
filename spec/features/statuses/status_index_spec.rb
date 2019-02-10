# frozen_string_literal: true

describe 'Status index page', type: :feature do
  it 'view the status list' do
    visit statuses_path
    expect(page).to have_content 'Statuses'
  end
end
