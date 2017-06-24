# https://www.w3.org/wiki/WirelessOntology

xml.instruct!

xml.rdf :RDF, {
  "xmlns:addr" => "http://www.w3.org/2000/10/swap/pim/contact#",
  "xmlns:foaf" => "http://xmlns.com/foaf/0.1/",
  "xmlns:geo" => "http://www.w3.org/2003/01/geo/wgs84_pos#",
  "xmlns:rdf" => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
  "xmlns:wl" => "http://downlode.org/rdf/wireless_networks/schema#"
} do
  xml.Node "rdf:ID" => @node.code do
    xml.foaf :homepage, node_url(@node)

    xml.wl :status, @node.status.name

    xml.wl :upSince, @node.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")

    xml.wl :location do
      xml.addr :Address do
        xml.addr :Street, @node.address

        xml.geo :lat, @node.latitude
        xml.geo :long, @node.longitude
      end
    end

    # TODO: wl:hasAntenna

    # TODO: wl:hasInterface

    # TODO: wl:meshesWith
  end
end
