# An Interface instance represents a network interface or connection with
# a relationship to a Host instance.
class Interface < ApplicationRecord
  belongs_to :host
  belongs_to :interface_type
  belongs_to :status
  has_many :interface_properties

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code, scope: :host_id
  validates_format_of :code, with: %r{\A[-_a-zA-Z0-9]+\z},
    message: 'contains unacceptable characters',
    if: Proc.new { |o| o.code && o.code.size > 1 }

  # TODO - look at using NetAddr::CIDR here

  validates_each :address_ipv4 do |record, attr, value|
    unless value.blank?
      unless value =~ %r{^(\d+)\.(\d+)\.(\d+)\.(\d+)/(\d+)$}
        record.errors.add attr, 'is not formatted correctly'
      else
        if $1.to_i < 0 || $1.to_i > 255 || $2.to_i < 0 || $2.to_i > 255 ||
            $3.to_i < 0 || $3.to_i > 255 || $4.to_i < 0 || $4.to_i > 255 ||
            $5.to_i < 0 || $5.to_i > 32
          record.errors.add attr, 'is out of range'
        end
      end
    end
  end
  validates_each :address_ipv6 do |record, attr, value|
    unless value.blank?
      unless value =~ %r{^([:0-9a-fA-F]*):([:0-9a-fA-F]*):([:0-9a-fA-F]*)/(\d+)$}
        record.errors.add attr, 'is not formatted correctly'
      else
        if $4.to_i < 0 || $4.to_i > 128
          record.errors.add attr, 'is out of range'
        end
      end
    end
  end
  validates_format_of :address_mac,
    with: %r{\A[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]\z},
    message: 'is not a valid MAC address',
    if: Proc.new { |o| o.address_mac && o.address_mac.size > 0 }
  validates_length_of :name, maximum: 128,
    if: Proc.new { |o| o.name && o.name.size > 0 }

  def to_param
    return nil if not id
    [id, code].join('-')
  end

  # Converts the values of the +code+ and +name+ attributes into a
  # link-friendly String instance.
  def display_name
    name.blank? ? '(' + code + ')' : '(' + code + ') ' + name
  end

  # Converts the value of the <tt>address_ipv4</tt> attribute into a
  # CIDR notation String instance.
  def ipv4_address
    address_ipv4 =~ %r{^(\d+)\.(\d+)\.(\d+)\.(\d+)/(\d+)$}
    return nil unless $1 and $2 and $3 and $4
    $1 + '.' + $2 + '.' + $3 + '.' + $4
  end

  # Converts the value of the <tt>address_ipv4</tt> attribute into a
  # CIDR prefix length.
  def ipv4_prefix
    address_ipv4 =~ %r{^(\d+)\.(\d+)\.(\d+)\.(\d+)/(\d+)$}
    $5
  end

  # Converts the value of the <tt>address_ipv4</tt> attribute into an
  # Ipv4Calculator::Subnet instance.
  def ipv4_calculated_subnet
    @ipv4_calculated_subnet ||= Ipv4Calculator::Subnet.new(address_ipv4)
  end

  # Converts the value of the <tt>address_ipv4</tt> attribute into an
  # IPv4 dotted-quad network address.
  def ipv4_network
    ipv4_calculated_subnet.network
  end

  # Converts the value of the <tt>address_ipv4</tt> attribute into an
  # IPv4 dotted-quad network mask.
  def ipv4_netmask
    ipv4_calculated_subnet.netmask
  end

  # Converts the value of the <tt>address_ipv4</tt> attribute into an
  # IPv4 dotted-quad broadcast address.
  def ipv4_broadcast
    ipv4_calculated_subnet.broadcast
  end

  # Determines if this Interface instance has a static IPv4 address.
  # It is assumed dynamic if the host address matches the network address.
  def ipv4_static_address?
    ipv4_network != ipv4_address
  end

  # Finds neighboring Interface instances based on IPv4 network
  # configuration data.
  def ipv4_neighbors
    unless @current_ipv4_neighbors
      @current_ipv4_neighbors = []

      host.node.hosts.each do |node_host|
        next if node_host == host

        node_host.interfaces.each do |interface|
          if Ipv4Calculator::subnet_neighbor_match?(address_ipv4, interface.address_ipv4)
            if interface.type.wireless && type.wireless
              if interface.wireless_interface && wireless_interface &&
                  (interface.wireless_interface.essid ==
                     wireless_interface.essid) &&
                  (interface.wireless_interface.channel ==
                     wireless_interface.channel)
                @current_ipv4_neighbors.push interface
              end
            end

            unless interface.type.wireless || type.wireless
              @current_ipv4_neighbors.push interface
            end
          end
        end
      end
    end

    @current_ipv4_neighbors
  end

  def ipv6_static_address? #:nodoc:
    raise NotImplementedError.new('IPv6 calculations not supported.')
  end

  def ipv6_neighbors #:nodoc:
    raise NotImplementedError.new('IPv6 calculations not supported.')
  end

  # This method calculates the median average center point of this
  # Interface instance based on data from the InterfacePoint model.
  def point
    return nil unless latitude and longitude and altitude
    {
      latitude: latitude,
      longitude: longitude,
      height: altitude,
      error: 0
    }
  end

  protected

  before_validation :set_defaults

  def set_defaults
    self.code = name.parameterize if code.blank? and name
  end
end
