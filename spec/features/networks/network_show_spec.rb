# frozen_string_literal: true

describe 'Network show page', type: :feature do
  let(:network) { create :network }

  it 'view the network page' do
    visit network_path(network)
    expect(page).to have_content network.name
  end
end
