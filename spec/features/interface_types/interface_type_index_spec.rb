# frozen_string_literal: true

describe 'Interface Type index page', type: :feature do
  it 'view the interface type list' do
    visit interface_types_path
    expect(page).to have_content 'Interface Types'
  end
end
