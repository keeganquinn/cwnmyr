# frozen_string_literal: true

describe 'Interface index page', type: :feature do
  before { visit interfaces_path }

  it { expect(page).to have_content 'Join Us' }
end
