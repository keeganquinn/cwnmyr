# frozen_string_literal: true

require 'resolv-replace'

EVENTS_URI = 'https://personaltelco.net/api/v0/events'

# Service to fetch Events from legacy system.
class FetchLegacyEventsService
  def fetch
    uri = URI.parse(EVENTS_URI)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)
    request['X-PTP-API-KEY'] = ENV['PTP_API_KEY']
    JSON.parse http.request(request).body
  end

  def call
    fetch['data'].flatten
  end
end
