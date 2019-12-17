# frozen_string_literal: true

require_dependency 'dot_diskless'

DIR_URL = 'https://www.google.com/maps?saddr=My+Location&daddr='
TWITTER_BASE = 'https://twitter.com'

# A Node instance represents a physical location at a scale somewhere
# between that of the Zone model and that of the InterfacePoint model.
class Node < ApplicationRecord
  has_paper_trail

  belongs_to :contact, optional: true
  belongs_to :status
  belongs_to :user, optional: true
  belongs_to :group, optional: true
  belongs_to :zone
  has_many :devices
  has_one_attached :logo

  accepts_nested_attributes_for :contact, reject_if: :all_blank

  validates_presence_of :code
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code, case_sensitive: false
  validates_format_of :code, with: /\A[-_a-zA-Z0-9]+\z/,
                             message: 'contains unacceptable characters',
                             allow_blank: true
  validates_presence_of :name
  validates_uniqueness_of :name
  validates :website, format: URI.regexp(%w[http https]), allow_blank: true
  validates :rss, format: URI.regexp(%w[http https]), allow_blank: true
  validates :twitter, format: /\A[_a-zA-Z0-9]+\z/, allow_blank: true
  validates :wiki, format: URI.regexp(%w[http https]), allow_blank: true
  validates :logo, content_type: { allow: ['image/jpeg', 'image/png'] }

  before_validation :set_defaults

  geocoded_by :address
  after_validation :geocode, if: :should_geocode?
  after_validation :geocode_reset, if: :should_geocode_reset?

  scope :ungrouped, -> { where(group_id: nil) }

  # Reset any existing geocode data.
  def geocode_reset
    self.latitude = nil
    self.longitude = nil
  end

  # Return true if the record should be geocoded.
  def should_geocode?
    address.present? && (address_changed? || !latitude || !longitude)
  end

  # Return true if the geocode data should be reset.
  def should_geocode_reset?
    !address.present?
  end

  # Canonical identifier.
  def to_param
    return unless id

    [id, code].join('-')
  end

  # URL to obtain driving directions.
  def directions_url
    "#{DIR_URL}#{URI.encode_www_form_component(address)}"
  end

  # URL to a Twitter feed.
  def twitter_url
    "#{TWITTER_BASE}/#{twitter}" unless twitter.blank?
  end

  # This method constructs an RGL::AdjacencyGraph instance based on this
  # Node instance, including related Interface instances and IPv4 neighbor
  # relationships.
  def graph(rgl = RGL::AdjacencyGraph.new)
    devices.each { |device| device.graph rgl }
    rgl
  end

  # Set default values.
  def set_defaults
    self.code = name.parameterize if code.blank? && name
    self.zone ||= Zone.default
  end

  # Version stamp for the attached logo.
  def logo_stamp
    logo.blob.created_at.to_i if logo.attached?
  end

  # Display-formatted code.
  def display_code
    "Node#{code}"
  end

  # Display-formatted name.
  def display_name
    "#{display_code}: #{name}"
  end
end
