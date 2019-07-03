# frozen_string_literal: true

require_dependency 'dot_diskless'

# A Node instance represents a physical location at a scale somewhere
# between that of the Zone model and that of the InterfacePoint model.
class Node < ApplicationRecord
  DIR_URL = 'https://www.google.com/maps?saddr=My+Location&daddr='

  acts_as_taggable
  has_paper_trail
  searchkick word_start: %i[code name body address notes tag_list]

  belongs_to :contact, optional: true
  belongs_to :status
  belongs_to :user, optional: true
  belongs_to :group, optional: true
  belongs_to :zone
  has_many :devices
  has_many :node_links, inverse_of: :node
  has_one_attached :logo

  accepts_nested_attributes_for :node_links,
                                reject_if: :all_blank, allow_destroy: true

  validates_presence_of :code
  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code, case_sensitive: false
  validates_format_of :code, with: /\A[-_a-zA-Z0-9]+\z/,
                             message: 'contains unacceptable characters',
                             allow_blank: true
  validates_presence_of :name
  validates_length_of :name, minimum: 1
  validates_uniqueness_of :name
  validates :logo, content_type: { allow: ['image/jpeg', 'image/png'] }

  before_validation :set_defaults

  geocoded_by :address
  after_validation :geocode, if: :should_geocode?
  after_validation :geocode_reset, if: :should_geocode_reset?

  scope :ungrouped, -> { where(group_id: nil) }

  def search_data
    {
      tag_list: tag_list.join(' ')
    }.merge(attributes)
  end

  def geocode_reset
    self.latitude = nil
    self.longitude = nil
  end

  def should_geocode?
    address.present? && (address_changed? || !latitude || !longitude)
  end

  def should_geocode_reset?
    !address.present?
  end

  def to_param
    return unless id

    [id, code].join('-')
  end

  def directions_url
    "#{DIR_URL}#{URI.encode_www_form_component(address)}"
  end

  # This method constructs an RGL::AdjacencyGraph instance based on this
  # Node instance, including related Interface instances and IPv4 neighbor
  # relationships.
  def graph(rgl = RGL::AdjacencyGraph.new)
    devices.each { |device| device.graph rgl }
    rgl
  end

  def set_defaults
    self.code = name.parameterize if code.blank? && name
    self.zone ||= Zone.default
  end

  def logo_stamp
    logo.blob.created_at.to_i if logo.attached?
  end

  def display_code
    "Node#{code}"
  end

  def display_name
    "#{display_code}: #{name}"
  end
end
