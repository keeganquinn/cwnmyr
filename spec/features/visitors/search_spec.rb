# frozen_string_literal: true

describe 'Visitor search page', type: :feature do
  before do
    Searchkick.models.each(&:reindex)

    visit search_path
  end

  it { expect(page).to have_content 'Search' }

  it 'allows a search query to be executed' do
    fill_in 'query', with: 'search for things!'
    click_button 'Search'
    expect(page).to have_content 'No Results'
  end
end
