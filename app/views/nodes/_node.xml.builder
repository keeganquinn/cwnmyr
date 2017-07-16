xml.Node 'rdf:ID': node.to_param do
  xml.foaf :homepage, node_url(node)

  xml.wl :nodeName, node.name

  xml.wl :status, node.status.name

  xml.wl :upSince, node.created_at.strftime('%Y-%m-%dT%H:%M:%SZ')

  xml.wl :location do
    xml.addr :Address do
      xml.addr :Street, node.address

      xml.geo :lat, node.latitude
      xml.geo :long, node.longitude
    end
  end

  # TODO: wl:hasAntenna

  # TODO: wl:hasInterface

  # TODO: wl:meshesWith
end
