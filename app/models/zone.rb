# frozen_string_literal: true

# A Zone instance represents a physical area at a large scale.  It serves
# as an organizational aid and the heirarchial root of the system when
# browsing in the user interface.
class Zone < ApplicationRecord
  has_paper_trail
  has_many :nodes

  has_one_attached :nav_logo
  has_one_attached :chromeicon_192
  has_one_attached :chromeicon_512
  has_one_attached :favicon_ico
  has_one_attached :favicon_png16
  has_one_attached :favicon_png32
  has_one_attached :maskicon_svg
  has_one_attached :mstile_150
  has_one_attached :touchicon_180

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code, case_sensitive: false
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      allow_blank: true
  validates_length_of :name, minimum: 1
  validates_length_of :name, maximum: 64
  validates :default, uniqueness: true, if: :default

  before_validation :set_defaults

  geocoded_by :address
  after_validation :geocode, if: :should_geocode?

  # Locate the default Zone.
  def self.default
    find_by default: true
  end

  # Return true if the record should be geocoded.
  def should_geocode?
    address.present? && (address_changed? || !latitude || !longitude)
  end

  # Canonical identifier.
  def to_param
    return unless id

    [id, code].join('-')
  end

  # Set default values.
  def set_defaults
    self.code = name.parameterize if code.blank? && name
    self.last_import ||= 0
    self.last_event_import ||= 0
  end

  # Version stamp for the attached navigation logo.
  def nav_logo_stamp
    nav_logo.blob.created_at.to_i if nav_logo.attached?
  end
end
