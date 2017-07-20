json.id node.to_param
json.name node.name

# Map markers
json.lat node.latitude.to_f if node.latitude
json.lng node.longitude.to_f if node.longitude
json.infowindow render(partial: 'nodes/node.html', locals: { node: node })
