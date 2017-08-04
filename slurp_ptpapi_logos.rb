require 'net/https'
require 'uri'

require_relative 'config/environment'

user = User.first
zone = Zone.find_by(code: 'pdx')

uri = URI.parse('https://personaltelco.net/api/v0/nodes')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Get.new(uri.request_uri)
request['X-PTP-API-KEY'] = ENV['PTP_API_KEY']

response = http.request(request)
data = JSON.parse response.body

data['data'].each do |nodes|
  nodes.each do |key, value|
    next if value['logo'].blank?
    node = Node.find_by(code: key)
    logo = "https://personaltelco.net/splash/images/nodes/#{value['logo']}"
    print node, logo, "\n"
    node.logo = URI.parse(logo)
    node.save
  end
end
