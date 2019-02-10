# frozen_string_literal: true

# Feature: Navigation links
#   As a visitor
#   I want to see navigation links
#   So I can find home, sign in, or sign up
describe 'Navigation links', type: :feature do
  before { visit root_path }

  it { expect(page).to have_content 'cwnmyr' }
  it { expect(page).to have_content 'Sign In' }
  it { expect(page).to have_content 'Sign Up' }
end
