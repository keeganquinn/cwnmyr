require_dependency 'dot_diskless'

# A Node instance represents a physical location at a scale somewhere
# between that of the Zone model and that of the InterfacePoint model.
class Node < ApplicationRecord
  belongs_to :contact, optional: true
  belongs_to :status
  belongs_to :user, optional: true
  belongs_to :zone
  has_many :hosts
  has_many :node_links
  has_and_belongs_to_many :tags

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code
  validates_format_of :code,
    with: %r{\A[-_a-zA-Z0-9]+\z},
    message: 'contains unacceptable characters',
    if: Proc.new { |o| o.code && o.code.size > 1 }
  validates_length_of :name, minimum: 1
  validates_uniqueness_of :name

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and (obj.address_changed? or not obj.latitude or not obj.longitude) }

  def to_param
    return nil if not id
    [id, code].join('-')
  end

  # This method constructs an RGL::AdjacencyGraph instance based on this
  # Node instance, including related Interface instances and IPv4 neighbor
  # relationships.
  def graph
    g = RGL::AdjacencyGraph.new

    hosts.each do |host|
      host.interfaces.each do |interface|
        g.add_edge(host.name, host.name + ': ' + interface.code)

        interface.ipv4_neighbors.each do |neighbor|
          g.add_edge(host.name + ': ' + interface.code,
                     neighbor.host.name + ': ' + neighbor.code)
        end
      end
    end

    g
  end

  # This method retrieves the primary Host instance which is related
  # to this Node instance, or +nil+ if there is none.
  def primary_host
    return nil if hosts.empty?
    return hosts.first if hosts.size == 1

    hosts.each do |host|
      return host  # FIXME if host is primary
    end

    return nil
  end

  # This method calculates the median average center point of this Node
  # instance based on data from the Host#average_point method.
  def average_point
    latitude, longitude, height, error, i = 0.0, 0.0, 0.0, 0.0, 0

    hosts.each do |host|
      if point = host.average_point
        i += 1
        latitude += point[:latitude]
        longitude += point[:longitude]
        height += point[:height]
        error += point[:error]
      end
    end

    return nil if i == 0

    {
      latitude: latitude./(i),
      longitude: longitude./(i),
      height: height./(i),
      error: error./(i)
    }
  end

  protected

  before_validation :set_defaults

  def set_defaults
    self.code = name.parameterize if code.blank? and name
  end
end
