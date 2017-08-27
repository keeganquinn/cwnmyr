Geocoder.configure(
  http_headers: { 'User-Agent' => ENV['DOMAIN_NAME'] },
  lookup: :google,
  use_https: true,
  api_key: ENV['GMAPS_API_KEY']
)
