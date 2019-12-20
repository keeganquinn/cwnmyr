# frozen_string_literal: true

LOGO_BASE = 'https://personaltelco.net/splash/images/nodes'

# Service to import data from legacy system.
class ImportLegacyDataService
  # Initialize the service with an admin User, a Zone, and a list of Node data.
  def initialize(nodes = nil)
    @user = User.admin.first
    @zone = Zone.default
    @nodes = nodes || FetchLegacyDataService.new(@zone).call
  end

  # Do the thing.
  def call
    @nodes.map do |value|
      node = if value['node'].starts_with?('Test')
               Node.find_by code: 'Klickitat'
             else
               build_node value
             end

      finalize_node node, value
      build_device node, value unless value['hostname'].blank?

      node
    end
  end

  protected

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
      logo = URI.parse("#{LOGO_BASE}/#{value['logo']}").open
      node.logo.attach io: logo, filename: value['logo']
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
    device = Device.find_or_create_by(
      node: node, name: value['hostname'],
      device_type: DeviceType.find_by(code: value['device'].try(:downcase))
    )

    build_prop device, 'bridge', value
    build_prop device, 'filter', value
    build_prop device, 'splashpageversion', value
    build_prop device, 'dhcpstart', value

    build_iface_pub device, value
    build_iface_priv device, value
  end

  def build_prop(device, key, value)
    return if value[key].blank?

    device_property_type = DevicePropertyType.find_or_create_by code: key
    DeviceProperty.find_or_create_by device: device,
                                     device_property_type: device_property_type,
                                     value: value[key]
  end

  def build_iface_pub(device, value)
    return if value['pubaddr'].blank?

    iface = Interface.find_or_initialize_by device: device, code: 'pub'
    iface.assign_attributes(
      name: 'Public Network',
      network: Network.find_by(code: 'ptpnet'),
      address_ipv4: "#{value['pubaddr']}/#{value['pubmasklen'] || '24'}"
    )
    iface.save!
  end

  def build_iface_priv(device, value)
    return if value['privaddr'].blank?

    iface = Interface.find_or_initialize_by device: device, code: 'priv'
    iface.assign_attributes(
      name: 'Private Network',
      address_ipv4: "#{value['privaddr']}/#{value['privmasklen'] || '24'}"
    )
    iface.save!
  end
end
