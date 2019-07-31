# frozen_string_literal: true

# A DeviceBuild refers to a specific binary software configuration or image
# for a Device.
class DeviceBuild < ApplicationRecord
  has_paper_trail

  belongs_to :build_provider
  belongs_to :device
  belongs_to :device_type

  validates_presence_of :title
  validates_presence_of :url
  validates :url, format: URI.regexp(%w[http https]), allow_blank: true
end
