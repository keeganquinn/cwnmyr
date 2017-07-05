json.id node.to_param

# Map markers
json.lat node.latitude
json.lng node.longitude
json.marker_title node.name
json.infowindow render(partial: 'nodes/node.html', locals: { node: node })
