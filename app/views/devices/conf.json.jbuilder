# frozen_string_literal: true

json.type 'nodeinfo'
json.apiVersion '0.1.1'
json.time Time.now.to_i

json.data do
  json.node @device.node&.code
  json.nodename @device.node&.name
  json.hostname @device.name
  json.description @device.node&.body
  json.notes @device.node&.notes
  json.status @device.node&.status&.code

  json.splashpageversion @device.splashpageversion
  if @device.node&.logo&.attached?
    json.logo \
      node_path(@device.node, format: 'png', _v: @device.node.logo_stamp)
  end
  json.device @device.device_type&.name
  json.bridge @device.bridge
  json.filter @device.filter
  json.pubaddr @device.pub.ipv4_address_nomask
  json.pubmasklen @device.pub.ipv4_masklen
  json.privaddr @device.priv.ipv4_address_nomask
  json.privmasklen @device.priv.ipv4_masklen
  json.dhcpstart @device.dhcpstart
  json.address @device.node&.address
  json.lat @device.node&.latitude
  json.lon @device.node&.longitude
  json.url @device.node&.website
  json.rss @device.node&.rss
  json.twitter @device.node&.twitter
  json.wikiurl @device.node&.wiki

  json.updated @device.updated_at.to_i
end
