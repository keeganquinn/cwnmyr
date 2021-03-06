# frozen_string_literal: true

# A BuildProvider represents a source of DeviceBuilds.
class BuildProvider < ApplicationRecord
  has_paper_trail
  has_many :device_builds
  has_many :device_types

  validates_presence_of :name
  validates_presence_of :url
  validates :url, format: URI.regexp(%w[http https]), allow_blank: true

  # Return true if this provider is able to produce builds for Devices.
  def can_build?
    active? && (mode.present? || (server.present? && job.present?))
  end

  # Build an image for a Device.
  def build(device)
    build_number = queue_build(device.to_param)
    return unless build_number

    device_builds.create device: device, device_type: device.device_type,
                         build_number: build_number,
                         url: "#{url}#{build_number}"
  end

  # Queue a build request.
  def queue_build(device_id)
    return queue_build_pass(device_id) if mode == 'pass'
    return queue_build_fail(device_id) if mode == 'fail'

    api = JenkinsApi::Client.new server_ip: server, server_port: 443, ssl: true
    return if api.job.get_current_build_status(job) == 'running'

    opts = { 'build_start_timeout' => 30 }
    begin
      api.job.build job, { id: device_id }, opts
    rescue JenkinsApi::Exceptions::ForbiddenWithCrumb
      nil
    end
  end

  # Stub method to simulate a successfully queued build.
  def queue_build_pass(_device_id)
    1
  end

  # Stub method to simulate an unsuccessfully queued build.
  def queue_build_fail(_device_id)
    nil
  end
end
