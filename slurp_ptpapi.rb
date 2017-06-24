#!/usr/bin/env ruby

require "net/https"
require "uri"

require_relative 'config/environment'


user = User.first
zone = Zone.find_by(code: 'pdx')

uri = URI.parse("https://personaltelco.net/api/v0/nodes")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Get.new(uri.request_uri)
request["X-PTP-API-KEY"] = ENV["PTP_API_KEY"]

response = http.request(request)
data = JSON.parse response.body

data['data'].each do |nodes|
  nodes.each do |key, value|
    status = Status.find_by(code: value['status'])

    node = Node.find_or_create_by(zone: zone, status: status, code: key, name: value['nodename'])
    print 'Node', key, ': ', value['nodename'], ' @ ', node.id, "\n"

    if value['contact']
      contact = Contact.find_or_create_by(name: value['contact'], hidden: true)
      contact.email = value['email']
      contact.phone = value['phone']
      contact.notes = value['role']
      contact.save
      node.contact = contact
    end

    node.user = user
    node.body = value['description']
    node.notes = value['notes']
    node.address = value['address']
    node.latitude = value['lat']
    node.longitude = value['lon']
    node.save

    if value['hostname']
      host = Host.find_or_create_by(node: node, status: status, name: value['hostname'])
      print '-> Host: ', value['hostname'], ' @ ', host.id, "\n"

      if value['device']
        host_type = HostType.find_by(code: value['device'].downcase)
        if host_type
          host.host_type = host_type
        end
        host.save
      end

      if value['filter']
        host_property = HostProperty.find_or_create_by(host: host, key: 'filter', value: value['filter'])
      end

      if value['splashpageversion']
        host_property = HostProperty.find_or_create_by(host: host, key: 'splashpageversion', value: value['splashpageversion'])
      end

      if value['dhcpstart']
        host_property = HostProperty.find_or_create_by(host: host, key: 'dhcpstart', value: value['dhcpstart'])
      end

      if value['pubaddr'] and value['pubmasklen']
        pub = InterfaceType.find_by(code: 'pub')
        pubIface = Interface.find_or_create_by(host: host, interface_type: pub, status: status, name: 'Public Network', address_ipv4: '%s/%s' % [value['pubaddr'], value['pubmasklen']])
      end

      if value['privaddr'] and value['privmasklen']
        priv = InterfaceType.find_by(code: 'priv')
        privIface = Interface.find_or_create_by(host: host, interface_type: priv, status: status, name: 'Private Network', address_ipv4: '%s/%s' % [value['privaddr'], value['privmasklen']])
      end
    end

    if value['url'] and not value['url'].blank?
      website = NodeLink.find_or_create_by(node: node, name: 'Website', url: value['url'])
      print '-> Link: ', value['url'], ' @ ', website.id, "\n"
    end

    if value['rss'] and not value['rss'].blank?
      rss = NodeLink.find_or_create_by(node: node, name: 'RSS Feed', url: value['rss'])
      print '-> Link: ', value['rss'], ' @ ', rss.id, "\n"
    end

    if value['twitter'] and not value['twitter'].blank?
      twitter = NodeLink.find_or_create_by(node: node, name: 'Twitter', url: "https://twitter.com/%s" % value['twitter'])
      print '-> Link: ', value['twitter'], ' @ ', twitter.id, "\n"
    end

    if value['wikiurl'] and not value['wikiurl'].blank?
      wiki = NodeLink.find_or_create_by(node: node, name: 'Wiki', url: value['wikiurl'])
      print '-> Link: ', value['wikiurl'], ' @ ', wiki.id, "\n"
    end

    # TODO: fetch and store the logo somewhere
  end
end
