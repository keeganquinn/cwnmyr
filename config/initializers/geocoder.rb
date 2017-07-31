unless Rails.env.test?
  Geocoder.configure(
    http_headers: { 'User-Agent' => ENV['DOMAIN_NAME'] },
    lookup: :nominatim
  )
end
