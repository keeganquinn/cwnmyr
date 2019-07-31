# frozen_string_literal: true

# A BuildProvider represents a source of DeviceBuilds.
class BuildProvider < ApplicationRecord
  has_paper_trail
  has_many :device_builds
  has_many :device_types

  validates_presence_of :name
  validates_presence_of :url
  validates :url, format: URI.regexp(%w[http https]), allow_blank: true

  def can_build?
    server.present? && job.present?
  end

  def build(device, url)
    api = JenkinsApi::Client.new server_ip: server, server_port: 443, ssl: true
    opts = { 'build_start_timeout': 10 }
    api.job.build job, { device: device, url: url }, opts
  end
end
