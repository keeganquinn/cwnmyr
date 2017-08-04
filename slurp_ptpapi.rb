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
    status = Status.find_by(code: value['status'])

    node = Node.find_or_create_by(
      zone: zone, status: status, code: key, name: value['nodename']
    )
    print 'Node', key, ': ', value['nodename'], ' @ ', node.id, "\n"

    if value['contact']
      contact = Contact.find_or_create_by(name: value['contact'], hidden: true)
      contact.email = value['email']
      contact.phone = value['phone']
      contact.notes = value['role']
      contact.user = user
      contact.save
      node.contact = contact
    end

    unless value['logo'].blank?
      logo = "https://personaltelco.net/splash/images/nodes/#{value['logo']}"
      node.logo = URI.parse(logo)
    end

    node.user = user
    node.body = value['description']
    node.notes = value['notes']
    node.address = value['address']
    # These values are present in datamanager but we choose to geocode instead.
    # node.latitude = value['lat']
    # node.longitude = value['lon']
    node.save

    if value['hostname']
      host = Host.find_or_create_by(
        node: node, name: value['hostname']
      )
      print '-> Host: ', value['hostname'], ' @ ', host.id, "\n"

      if value['device']
        host_type = HostType.find_by(code: value['device'].downcase)
        host.host_type = host_type if host_type
        host.save
      end

      if value['filter']
        host_property = HostProperty.find_or_create_by(
          host: host, key: 'filter', value: value['filter']
        )
        print '--> Property: ', host_property.key,
              ' = ', host_property.value, "\n"
      end

      if value['splashpageversion']
        host_property = HostProperty.find_or_create_by(
          host: host, key: 'splashpageversion',
          value: value['splashpageversion']
        )
        print '--> Property: ', host_property.key,
              ' = ', host_property.value, "\n"
      end

      if value['dhcpstart']
        host_property = HostProperty.find_or_create_by(
          host: host, key: 'dhcpstart', value: value['dhcpstart']
        )
        print '--> Property: ', host_property.key,
              ' = ', host_property.value, "\n"
      end

      if value['pubaddr'] && value['pubmasklen']
        pub = InterfaceType.find_by(code: 'pub')
        interface = Interface.find_or_create_by(
          host: host, interface_type: pub,
          name: 'Public Network',
          address_ipv4: "#{value['pubaddr']}/#{value['pubmasklen']}"
        )
        print '--> Interface: ', interface.interface_type, interface.name,
              ' @ ', interface.address_ipv4, "\n"
      end

      if value['privaddr'] && value['privmasklen']
        priv = InterfaceType.find_by(code: 'priv')
        interface = Interface.find_or_create_by(
          host: host, interface_type: priv,
          name: 'Private Network',
          address_ipv4: "#{value['privaddr']}/#{value['privmasklen']}"
        )
        print '--> Interface: ', interface.interface_type, interface.name,
              ' @ ', interface.address_ipv4, "\n"
      end
    end

    if value['url'] && !value['url'].blank?
      website = NodeLink.find_or_create_by(
        node: node, name: 'Website', url: value['url']
      )
      print '-> Link: ', value['url'], ' @ ', website.id, "\n"
    end

    if value['rss'] && !value['rss'].blank?
      rss = NodeLink.find_or_create_by(
        node: node, name: 'RSS Feed', url: value['rss']
      )
      print '-> Link: ', value['rss'], ' @ ', rss.id, "\n"
    end

    if value['twitter'] && !value['twitter'].blank?
      twitter = NodeLink.find_or_create_by(
        node: node, name: 'Twitter',
        url: "https://twitter.com/#{value['twitter']}"
      )
      print '-> Link: ', value['twitter'], ' @ ', twitter.id, "\n"
    end

    if value['wikiurl'] && !value['wikiurl'].blank?
      wiki = NodeLink.find_or_create_by(
        node: node, name: 'Wiki', url: value['wikiurl']
      )
      print '-> Link: ', value['wikiurl'], ' @ ', wiki.id, "\n"
    end
  end
end
