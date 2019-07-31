# frozen_string_literal: true

# A BuildProvider represents a source of DeviceBuilds.
class BuildProvider < ApplicationRecord
  has_paper_trail
  has_many :device_builds
  has_many :device_types

  validates_presence_of :name
  validates_presence_of :url
  validates :url, format: URI.regexp(%w[http https]), allow_blank: true
end
