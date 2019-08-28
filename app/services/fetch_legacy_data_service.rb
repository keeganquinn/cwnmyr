# frozen_string_literal: true

require 'resolv-replace'

SKIP = %w[Keegan Quinn].freeze
SOURCE_URI = 'https://personaltelco.net/api/v0/nodes'

# Service to fetch data from legacy system.
class FetchLegacyDataService
  def initialize(zone = nil)
    @zone = zone || Zone.default
  end

  def fetch
    uri = URI.parse(SOURCE_URI)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)
    request['X-PTP-API-KEY'] = ENV['PTP_API_KEY']
    JSON.parse http.request(request).body
  end

  def call
    fetch['data'].flatten.map(&:values).flatten.reject do |value|
      (@zone.last_import >= (value['updated'] || 0)) ||
        SKIP.include?(value['node'])
    end
  end
end
