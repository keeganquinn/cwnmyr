# frozen_string_literal: true

# A Network can be used to connect multiple Interfaces.
class Network < ApplicationRecord
  has_paper_trail
  has_many :interfaces

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code, case_sensitive: false
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      allow_blank: true
  validates_length_of :name, minimum: 1
  validates_length_of :name, maximum: 255

  validates_each :network_ipv4 do |record, attr, value|
    unless value.blank?
      begin
        NetAddr::IPv4Net.parse value
      rescue NetAddr::ValidationError
        record.errors.add attr, 'is not formatted correctly'
      end
    end
  end

  validates_each :network_ipv6 do |record, attr, value|
    unless value.blank?
      begin
        NetAddr::IPv6Net.parse value
      rescue NetAddr::ValidationError
        record.errors.add attr, 'is not formatted correctly'
      end
    end
  end

  before_validation :set_defaults

  def to_param
    return unless id

    [id, code].join('-')
  end

  def set_defaults
    self.code = name.parameterize if code.blank? && name
  end
end
