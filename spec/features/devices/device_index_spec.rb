# frozen_string_literal: true

describe 'Device index page', type: :feature do
  before { visit devices_path }

  it { expect(page).to have_current_path browse_path }
end
