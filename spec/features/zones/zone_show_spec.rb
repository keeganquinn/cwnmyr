feature 'Zone show page' do
  let(:zone) { create :zone }

  before { visit zone_path(zone) }

  it { expect(page).to have_content zone.name }
end
