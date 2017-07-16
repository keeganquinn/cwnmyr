xml.instruct!

xml.kml('xmlns': 'http://www.opengis.net/kml/2.2',
        'xmlns:atom': 'http://www.w3.org/2005/Atom') do
  xml.Document do
    xml.name t(:cwnmyr)
    xml.tag! 'atom:link', href: root_url
    xml.description t(:tagline)

    Node.all.each do |node|
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
