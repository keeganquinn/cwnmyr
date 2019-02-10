# frozen_string_literal: true

# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
describe 'Home page', type: :feature do
  before { visit root_path }

  it { expect(page).to have_content 'Welcome' }
  it { expect(page).to have_selector "#map[data-center='disco']" }
end
