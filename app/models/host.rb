# Each Host instance represents a network device which is used at a Node.
class Host < ApplicationRecord
  belongs_to :node
  belongs_to :host_type, optional: true
  belongs_to :status
  has_many :interfaces
  has_many :host_properties

  validates_length_of :name, minimum: 1
  validates_uniqueness_of :name, scope: :node_id
  validates_format_of :name, with: %r{\A[-a-zA-Z0-9]+\z},
    message: 'contains unacceptable characters',
    if: Proc.new { |o| o.name.size > 1 }

  def to_param
    [id, name].join('-')
  end

  # This method constructs an RGL::AdjacencyGraph instance based on this
  # Host instance, including related Interface instances and IPv4 neighbor
  # relationships.
  def graph
    g = RGL::AdjacencyGraph.new

    interfaces.each do |interface|
      g.add_edge(name, name + ': ' + interface.code)

      interface.ipv4_neighbors.each do |neighbor|
        g.add_edge(name + ': ' + interface.code,
                   neighbor.host.name + ': ' + neighbor.code)
      end
    end

    g
  end

  # This method retrieves the primary Interface instance which is related
  # to this Host instance, or +nil+ if there is none.
  def primary_interface
    return nil if interfaces.empty?
    return interfaces.first if interfaces.size == 1

    interfaces.each do |interface|
      return interface  # FIXME if interface is primary
    end

    return nil
  end

  # This method retrieves the external Interface instance which is related
  # to this Host instance, or +nil+ if there is none.
  def external_interface
    return nil if interfaces.empty?

    interfaces.each do |interface|
      return interface  # FIXME if interface is external
    end

    return nil
  end

  # This method calculates the median average center point of this Host
  # instance based on data from the Interface#average_point method.
  def average_point
    latitude, longitude, height, error, i = 0.0, 0.0, 0.0, 0.0, 0

    interfaces.each do |interface|
      if point = interface.point
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
end
