# frozen_string_literal: true

describe 'Node Link index page', type: :feature do
  before { visit node_links_path }

  it { expect(page).to have_content 'Join Us' }
end
