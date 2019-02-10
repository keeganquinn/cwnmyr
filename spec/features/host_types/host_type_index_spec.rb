# frozen_string_literal: true

describe 'Host Type index page', type: :feature do
  it 'view the host type list' do
    visit host_types_path
    expect(page).to have_content 'Host Types'
  end
end
