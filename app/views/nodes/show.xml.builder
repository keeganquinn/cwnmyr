# frozen_string_literal: true

# https://www.w3.org/wiki/WirelessOntology

xml.instruct!

xml.rdf :RDF,
        'xmlns:addr': 'http://www.w3.org/2000/10/swap/pim/contact#',
        'xmlns:foaf': 'http://xmlns.com/foaf/0.1/',
        'xmlns:geo': 'http://www.w3.org/2003/01/geo/wgs84_pos#',
        'xmlns:rdf': 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
        'xmlns:wl': 'http://downlode.org/rdf/wireless_networks/schema#' do
  xml << render(partial: 'nodes/node.xml', locals: { node: @node })
end
