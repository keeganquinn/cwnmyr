# frozen_string_literal: true

require_dependency 'dot_diskless'

# Each Device instance represents a network device which is used at a Node.
class Device < ApplicationRecord
  has_paper_trail

  belongs_to :node
  belongs_to :device_type, optional: true
  has_many :authorized_hosts, inverse_of: :device
  has_many :interfaces, inverse_of: :device
  has_many :device_builds, inverse_of: :device
  has_many :device_properties, inverse_of: :device

  accepts_nested_attributes_for :authorized_hosts,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :interfaces,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :device_properties,
                                reject_if: :all_blank, allow_destroy: true

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :node_id, case_sensitive: false
  validates_format_of :name,
                      with: /\A[a-z][-a-z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      allow_blank: true

  # Canonical identifier.
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

  # Locate the first public interface.
  def pub
    interfaces.where(code: 'pub').first
  end

  # Locate the first private interface.
  def priv
    interfaces.where(code: 'priv').first
  end

  # Return true if linked to a DeviceType with a configured BuildProvider.
  def can_build?
    device_type&.build_provider&.can_build?
  end

  # Generate build configuration data.
  def build_config
    props = device_properties.with_config.map(&:device_property_type)
    (device_type&.config || '') + "\n" + props.map(&:config).join("\n")
  end
end
