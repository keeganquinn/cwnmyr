# Service to import data from legacy system.
class ImportLegacyDataService
  SOURCE_URI = 'https://personaltelco.net/api/v0/nodes'.freeze
  LOGO_BASE = 'https://personaltelco.net/splash/images/nodes'.freeze

  def user
    User.admin.first
  end

  def zone
    Zone.find_by code: 'pdx'
  end

  def nodes
    uri = URI.parse(SOURCE_URI)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)
    request['X-PTP-API-KEY'] = ENV['PTP_API_KEY']

    JSON.parse(http.request(request).body)['data'].flatten.map(&:values).flatten
  end

  def call
    nodes.map do |value|
      node = build_node value
      finalize_node node, value

      build_link node, 'Website', 'url', value
      build_link node, 'RSS Feed', 'rss', value
      build_link node, 'Twitter', 'twitter', value
      build_link node, 'Wiki', 'wikiurl', value
      build_host node, value

      node
    end
  end

  def build_node(value)
    node = Node.find_or_initialize_by zone: zone, code: value['node']
    node.assign_attributes(
      status: Status.find_by(code: value['status']),
      name: value['nodename'], body: value['description'],
      notes: value['notes'], address: value['address']
    )
    node
  end

  def finalize_node(node, value)
    unless value['logo'].blank?
      begin
        node.logo = URI.parse("#{LOGO_BASE}/#{value['logo']}")
      rescue
        nil
      end
    end

    node.contact = build_contact(value) if value['contact']
    node.user ||= user

    node.save
  end

  def build_contact(value)
    contact = Contact.find_or_initialize_by name: value['contact'], hidden: true
    contact.email = value['email']
    contact.phone = value['phone']
    contact.notes ||= value['role']
    contact.user ||= user
    contact.save && contact
  end

  def build_link(node, name, key, value)
    return unless value[key]
    NodeLink.find_or_create_by node: node, name: name, url: value[key]
  end

  def build_host(node, value)
    return unless value['hostname']

    host = Host.find_or_create_by(
      node: node, name: value['hostname'],
      host_type: HostType.find_by(code: value['device'].try(:downcase))
    )

    build_prop host, 'filter', value
    build_prop host, 'splashpageversion', value
    build_prop host, 'dhcpstart', value

    build_iface_pub host, value
    build_iface_priv host, value
  end

  def build_prop(host, key, value)
    return unless value[key]
    HostProperty.find_or_create_by host: host, key: key, value: value[key]
  end

  def build_iface_pub(host, value)
    return unless value['pubaddr']
    pub = InterfaceType.find_by code: 'pub'
    mask = value['pubmasklen'] || '24'
    Interface.find_or_create_by host: host, interface_type: pub,
                                name: 'Public Network',
                                address_ipv4: "#{value['pubaddr']}/#{mask}"
  end

  def build_iface_priv(host, value)
    return unless value['privaddr']
    priv = InterfaceType.find_by code: 'priv'
    mask = value['privmasklen'] || '24'
    Interface.find_or_create_by host: host, interface_type: priv,
                                name: 'Private Network',
                                address_ipv4: "#{value['privaddr']}/#{mask}"
  end
end
