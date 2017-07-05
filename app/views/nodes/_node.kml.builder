xml.Placemark do
  xml.name node.name
  xml.tag! 'atom:link', href: node_url(node)
  xml.address node.address
  xml.description do
    xml.cdata! markdown(node.body) if node.body
  end

  xml.Point do
     xml.coordinates "#{node.longitude},#{node.latitude},0"
  end
end
