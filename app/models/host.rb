require_dependency 'dot_diskless'

# Each Host instance represents a network device which is used at a Node.
class Host < ApplicationRecord
  has_paper_trail
  belongs_to :node
  belongs_to :host_type, optional: true
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
  def graph(g = RGL::AdjacencyGraph.new)
    interfaces.each do |interface|
      g.add_edge name, name + ': ' + interface.code
      interface.graph g
    end
    g
  end
end
