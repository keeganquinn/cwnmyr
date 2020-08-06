# frozen_string_literal: true

describe ImportLegacyEventsService do
  subject(:service) { described_class }

  before { create :zone, default: true }

  event_data = [
    {
      'name' => 'Join Us for Love Letters to Municipal Broadband',
      'description' => '<p>Join us <b>February 10 at 2PM</b> for event.</p>',
      'action' => {
        'url' => 'https://www.facebook.com/events/1967325360196872/',
        'priority' => false,
        'text' => 'Get the facts about municipal broadband!'
      },
      'starts' => 1_518_300_000_000,
      'ends' => 1_518_307_200_000,
      'image' => 'https://personaltelco.net/splash/images/events/MuniBBFeb10.jpg',
      'splash' => {
        'position' => 'top'
      },
      'id' => 'd29d24f13000b5fe7ccd407eba4def63',
      'updated' => 1_517_520_563_977
    }, {
      'name' => 'A Musical Rally for Municipal Broadband',
      'description' => '<p>Join us <b>March 31 at 2PM</b>! Help us!</p>',
      'action' => {
        'url' => 'https://www.facebook.com/events/1835210780110472/',
        'priority' => false,
        'text' => 'Learn more about the musical rally for municipal broadband'
      },
      'starts' => 1_522_530_000_000,
      'ends' => 1_522_537_200_000,
      'image' => 'https://personaltelco.net/splash/images/events/MuniBBMar18.jpg',
      'splash' => {
        'position' => 'top'
      },
      'id' => '0ae4f390e99afbe9c92a8f7b5498e145',
      'updated' => 1_522_342_897_024
    }
  ].freeze

  let!(:events) { service.new(event_data).call }

  xit 'returns events' do
    expect(events).not_to be_empty
  end

  xit 'creates event records' do
    expect(Event.count).to be_positive
  end
end
