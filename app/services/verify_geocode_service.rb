# frozen_string_literal: true

# Service to verify geocoding results.
class VerifyGeocodeService
  def call
    Node.where.not(address: nil).map do |node|
      next if node.address.blank?

      check_range(node, node.zone.latitude, node.zone.longitude) || next
    end.compact
  end

  def check_range(node, expected_latitude, expected_longitude)
    return unless node.latitude && node.longitude

    lat_diff = (expected_latitude - node.latitude).abs
    long_diff = (expected_longitude - node.longitude).abs
    return unless lat_diff >= 0.5 || long_diff >= 0.5

    "#{node.id} #{node.code}: location out of range: #{node.address}"
  end
end
