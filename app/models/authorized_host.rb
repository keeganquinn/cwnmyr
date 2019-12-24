# frozen_string_literal: true

# An AuthorizedHost represents a known host that is frequently connected to a
# Device and should be granted special privileges or configuration attributes.
class AuthorizedHost < ApplicationRecord
  has_paper_trail
  belongs_to :device

  validates_each :address_ipv4 do |record, attr, value|
    unless value.blank?
      begin
        NetAddr::IPv4Net.parse value
      rescue NetAddr::ValidationError
        record.errors.add attr, 'is not formatted correctly'
      end
    end
  end

  validates_each :address_ipv6 do |record, attr, value|
    unless value.blank?
      begin
        NetAddr::IPv6Net.parse value
      rescue NetAddr::ValidationError
        record.errors.add attr, 'is not formatted correctly'
      end
    end
  end

  validates_format_of :address_mac,
                      with: /\A[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]
                            :[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]
                            :[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]\z/x,
                      message: 'is not a valid MAC address',
                      allow_blank: true
  validates_length_of :name,
                      maximum: 128,
                      allow_blank: true
end
