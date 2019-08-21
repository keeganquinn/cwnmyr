# frozen_string_literal: true

require 'resolv-replace'

SKIP = %w[Keegan Quinn].freeze
SOURCE_URI = 'https://personaltelco.net/api/v0/nodes'
LOGO_BASE = 'https://personaltelco.net/splash/images/nodes'

# Service to import data from legacy system.
class ImportLegacyDataService
  def initialize(nodes = nil)
    @nodes = nodes
    @user = User.admin.first
    @zone = Zone.find_by code: 'pdx'
  end

  def nodes
    @nodes ||= fetch['data'].flatten.map(&:values).flatten.reject do |value|
      @zone.last_import >= (value['updated'] || 0)
    end
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
    nodes.reject { |v| SKIP.include? v['node'] }.map do |value|
      node = if value['node'].starts_with?('Test')
               Node.find_by code: 'Klickitat'
             else
               build_node value
             end

      finalize_node node, value
      build_device node, value
      node
    end
  end

  def build_node(value)
    node = Node.find_or_initialize_by zone: @zone, code: value['node']
    node.assign_attributes(
      status: Status.find_by(code: value['status']),
      name: value['nodename'], body: value['description'],
      notes: value['notes'], address: value['address'],
      website: value['url'], rss: value['rss'],
      twitter: value['twitter'], wiki: value['wikiurl']
    )
    node
  end

  def attach_logo(node, value)
    return if value['logo'].blank? || node.logo.attached?

    begin
      URI.parse("#{LOGO_BASE}/#{value['logo']}").open do |logo|
        node.logo.attach io: logo, filename: value['logo']
      end
    rescue OpenURI::HTTPError
      nil
    end
  end

  def finalize_node(node, value)
    attach_logo node, value

    node.contact = build_contact(value) unless value['contact'].blank?
    node.user ||= @user
    node.group ||= node.user&.groups&.first

    update_stamp value['updated']
    node.save!
  end

  def update_stamp(stamp)
    return unless stamp && stamp > @zone.last_import

    @zone.last_import = stamp
    @zone.save!
  end

  def build_contact(value)
    contact = Contact.find_or_initialize_by name: value['contact'], hidden: true
    contact.email = value['email']
    contact.phone = value['phone']
    contact.notes ||= value['role']
    contact.user ||= @user
    contact.group ||= contact.user&.groups&.first
    # TODO: use save! here, need to support splitting into multiple contacts
    contact.save && contact
  end

  def build_device(node, value)
    return if value['hostname'].blank?

    device = Device.find_or_create_by(
      node: node, name: value['hostname'],
      device_type: DeviceType.find_by(code: value['device'].try(:downcase))
    )

    build_prop device, 'filter', value
    build_prop device, 'splashpageversion', value
    build_prop device, 'dhcpstart', value

    build_iface_pub device, value
    build_iface_priv device, value
  end

  def build_prop(device, key, value)
    return unless value[key]

    DeviceProperty.find_or_create_by device: device, key: key, value: value[key]
  end

  def build_iface_pub(device, value)
    return if value['pubaddr'].blank?

    ptpnet = Network.find_by code: 'ptpnet'
    mask = value['pubmasklen'] || '24'
    iface = Interface.find_or_initialize_by device: device,
                                            name: 'Public Network'
    iface.code = 'pub'
    iface.network = ptpnet
    iface.address_ipv4 = "#{value['pubaddr']}/#{mask}"
    iface.save!
  end

  def build_iface_priv(device, value)
    return if value['privaddr'].blank?

    mask = value['privmasklen'] || '24'
    iface = Interface.find_or_initialize_by device: device,
                                            name: 'Private Network'
    iface.code = 'priv'
    iface.network = nil
    iface.address_ipv4 = "#{value['privaddr']}/#{mask}"
    iface.save!
  end
end
