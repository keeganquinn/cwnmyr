# Service to verify geocoding results.
class VerifyGeocodeService
  # Should stick this in the zone eventually.
  EXPECTED_LATITUDE = 45.51894475
  EXPECTED_LONGITUDE = -122.679545541875

  def call
    Node.where.not(address: nil).map do |node|
      next if node.address.blank?
      check_missing(node) || check_range(node) || next
    end.compact
  end

  def check_missing(node)
    return if node.latitude && node.longitude
    "#{node.id} #{node.code}: not geocoded: #{node.address}"
  end

  def check_range(node)
    return unless node.latitude && node.longitude
    lat_diff = (EXPECTED_LATITUDE - node.latitude).abs
    long_diff = (EXPECTED_LONGITUDE - node.longitude).abs
    return unless lat_diff >= 0.5 || long_diff >= 0.5
    "#{node.id} #{node.code}: location out of range: #{node.address}"
  end
end
