# frozen_string_literal: true

xml.instruct!

xml.kml('xmlns': 'http://www.opengis.net/kml/2.2',
        'xmlns:atom': 'http://www.w3.org/2005/Atom') do
  xml.Document do
    xml.name @zone.name
    xml.tag! 'atom:link', href: zone_url(@zone)
    xml.description do
      xml.cdata! markdown(@zone.body) if @zone.body
    end

    @zone.nodes.each do |node|
      next unless node.latitude && node.longitude

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
    end
  end
end
