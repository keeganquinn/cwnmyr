json.id node.to_param
json.name node.name

# This assumes that the first character of each status name is a letter,
# and that there is a set of icons for each status color. Use caution when
# changing status colors; you may need to generate new icons or update this.
icon = "#{node.status.color}_Marker#{node.status.name[0].upcase}"
json.icon asset_url("markers/#{icon}.png")

# Map markers
json.lat node.latitude.to_f if node.latitude
json.lng node.longitude.to_f if node.longitude
json.infowindow render(partial: 'nodes/node.html', locals: { node: node })
