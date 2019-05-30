# frozen_string_literal: true

# Each DeviceType instance represents a type of Device.
class DeviceType < ApplicationRecord
  has_paper_trail
  has_many :devices

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code, case_sensitive: false
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      allow_blank: true
  validates_length_of :name, minimum: 1
  validates_length_of :name, maximum: 255

  before_validation :set_defaults

  def to_param
    return unless id

    [id, code].join('-')
  end

  def set_defaults
    self.code = name.parameterize if code.blank? && name
  end
end
