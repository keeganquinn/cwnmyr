# Each Host instance represents a network device which is used at a Node.
class Host < ApplicationRecord
  belongs_to :node
  belongs_to :host_type, optional: true
  belongs_to :status
  has_many :interfaces
  has_many :host_properties

  validates_length_of :name, minimum: 1
  validates_uniqueness_of :name, scope: :node_id
  validates_format_of :name,
                      with: /\A[-a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      if: proc { |o| o.name.size > 1 }

  def to_param
    return unless id
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
      return interface # FIXME: if interface is primary
    end
  end

  # This method retrieves the external Interface instance which is related
  # to this Host instance, or +nil+ if there is none.
  def external_interface
    return nil if interfaces.empty?

    interfaces.each do |interface|
      return interface # FIXME: if interface is external
    end
  end
end
