describe 'Zone show page', type: :feature do
  let(:zone) { create :zone }

  before { visit zone_path(zone) }

  it { expect(page).to have_content zone.name }

  it 'allows an external BIND DNS zone to be generated' do
    click_link 'BIND DNS Zone (External)'
    expect(page).to have_content zone.name
  end

  it 'allows an internal BIND DNS zone to be generated' do
    click_link 'BIND DNS Zone (Internal)'
    expect(page).to have_content zone.name
  end

  it 'allows an external Nagios config to be generated' do
    click_link 'Nagios Configuration (External)'
    expect(page).to have_content zone.name
  end

  it 'allows an internal Nagios config to be generated' do
    click_link 'Nagios Configuration (Internal)'
    expect(page).to have_content zone.name
  end

  it 'allows an external SmokePing config to be generated' do
    click_link 'SmokePing Configuration (External)'
    expect(page).to have_content zone.name
  end

  it 'allows an internal SmokePing config to be generated' do
    click_link 'SmokePing Configuration (Internal)'
    expect(page).to have_content zone.name
  end
end
