# frozen_string_literal: true

addresses = {
  '727 SE Grand Ave, Portland, OR 97214' => {
    latitude: 45.5174948,
    longitude: -122.6609933,
    address: '727 SE Grand Ave, Portland, OR 97214',
    city: 'Portland',
    state: 'Oregon',
    state_code: 'OR',
    country: 'United States',
    country_code: 'US'
  },
  '709 W 27th St., Vancouver, WA 98660' => {
    latitude: 45.6408266,
    longitude: -122.6788378,
    address: '709 W 27th St., Vancouver, WA 98660',
    city: 'Vancouver',
    state: 'Washington',
    state_code: 'WA',
    country: 'United States',
    country_code: 'US'
  },
  '9150 Chesapeake Drive, San Diego, CA' => {
    latitude: 32.83929920000001,
    longitude: -117.1311171,
    address: '9150 Chesapeake Drive, San Diego, CA',
    city: 'San Diego',
    state: 'California',
    state_code: 'CA',
    country: 'United States',
    country_code: 'US'
  }
}

Geocoder.configure(lookup: :test)
addresses.each do |lookup, results|
  Geocoder::Lookup::Test.add_stub(lookup, [results])
end
