# frozen_string_literal: true

require_dependency 'dot_diskless'

# Each Device instance represents a network device which is used at a Node.
class Device < ApplicationRecord
  has_paper_trail
  belongs_to :node
  belongs_to :device_type, optional: true
  has_many :interfaces
  has_many :device_properties

  validates_length_of :name, minimum: 1
  validates_uniqueness_of :name, scope: :node_id, case_sensitive: false
  validates_format_of :name,
                      with: /\A[-a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      allow_blank: true

  def to_param
    return unless id

    [id, name].join('-')
  end

  # This method constructs an RGL::AdjacencyGraph instance based on this
  # Device instance, including related Interface instances and IPv4 neighbor
  # relationships.
  def graph(rgl = RGL::AdjacencyGraph.new)
    interfaces.each do |interface|
      rgl.add_edge name, name + ': ' + interface.code
      interface.graph rgl
    end
    rgl
  end
end
