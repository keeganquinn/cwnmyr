# frozen_string_literal: true

require_dependency 'dot_diskless'

# An Interface instance represents a network interface or connection with
# a relationship to a Device instance.
class Interface < ApplicationRecord
  has_paper_trail
  belongs_to :device
  belongs_to :interface_type
  has_many :interface_properties

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code, scope: :device_id, case_sensitive: false
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      allow_blank: true

  validates_each :address_ipv4 do |record, attr, value|
    unless value.blank?
      begin
        NetAddr::IPv4Net.parse value
      rescue NetAddr::ValidationError
        record.errors.add attr, 'is not formatted correctly'
      end
    end
  end

  validates_each :address_ipv6 do |record, attr, value|
    unless value.blank?
      begin
        NetAddr::IPv6Net.parse value
      rescue NetAddr::ValidationError
        record.errors.add attr, 'is not formatted correctly'
      end
    end
  end

  validates_format_of :address_mac,
                      with: /\A[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]
                            :[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]
                            :[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]\z/x,
                      message: 'is not a valid MAC address',
                      allow_blank: true
  validates_length_of :name,
                      maximum: 128,
                      allow_blank: true

  before_validation :set_defaults

  def to_param
    return unless id

    [id, code].join('-')
  end

  # Converts the value of the <tt>address_ipv4</tt> attribute into an
  # NetAddr::IPv4Net instance.
  def ipv4_cidr
    NetAddr::IPv4Net.parse address_ipv4 unless address_ipv4.blank?
  end

  # Extract the network address from the NetAddr representation.
  def ipv4_net
    ipv4_cidr.network.to_s
  end

  # Finds neighboring Interface instances based on IPv4 network
  # configuration data.
  def ipv4_neighbors
    return [] unless ipv4_cidr && interface_type.allow_neighbors

    interface_type.interfaces.where.not(id: id).select do |other|
      ipv4_net == other.ipv4_net
    end
  end

  def graph(rgl = RGL::AdjacencyGraph.new)
    ipv4_neighbors.each do |neighbor|
      rgl.add_edge name + ': ' + code,
                   neighbor.device.name + ': ' + neighbor.code
    end
    rgl
  end

  def set_defaults
    self.code = name.parameterize if code.blank? && name
  end
end
