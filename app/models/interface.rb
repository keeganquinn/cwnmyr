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
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      if: proc { |o| o.code && o.code.size > 1 }

  validates_each :address_ipv4 do |record, attr, value|
    unless value.blank?
      begin
        NetAddr::CIDR.create value
      rescue
        record.errors.add attr, 'is not formatted correctly'
      end
    end
  end

  validates_each :address_ipv6 do |record, attr, value|
    unless value.blank?
      begin
        NetAddr::CIDR.create value
      rescue
        record.errors.add attr, 'is not formatted correctly'
      end
    end
  end

  validates_format_of :address_mac,
                      with: /\A[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]
                            :[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]
                            :[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]\z/x,
                      message: 'is not a valid MAC address',
                      if: proc { |o| o.address_mac && !o.address_mac.empty? }
  validates_length_of :name,
                      maximum: 128,
                      if: proc { |o| o.name && !o.name.empty? }

  before_validation :set_defaults

  def to_param
    return unless id
    [id, code].join('-')
  end

  # Converts the value of the <tt>address_ipv4</tt> attribute into an
  # NetAddr::CIDR instance.
  def ipv4_cidr
    NetAddr::CIDR.create address_ipv4
  end

  # Finds neighboring Interface instances based on IPv4 network
  # configuration data.
  def ipv4_neighbors
    interface_type.interfaces.where.not(id: id).select do |other|
      ipv4_cidr.network == other.ipv4_cidr.network
    end
  end

  def set_defaults
    self.code = name.parameterize if code.blank? && name
  end
end
