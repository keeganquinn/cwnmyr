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

  def build(device, conf_url)
    build_number = queue_build(conf_url)
    return unless build_number

    device_builds.create device: device, device_type: device.device_type,
                         build_number: build_number,
                         url: "#{url}#{build_number}"
  end

  def queue_build(conf_url)
    api = JenkinsApi::Client.new server_ip: server, server_port: 443, ssl: true
    return if api.job.get_current_build_status(job) == 'running'

    opts = { 'build_start_timeout' => 30 }
    api.job.build job, { url: conf_url }, opts
  end
end
