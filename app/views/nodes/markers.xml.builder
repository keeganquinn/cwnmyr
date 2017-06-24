xml.instruct!

xml.kml('xmlns': 'http://www.opengis.net/kml/2.2',
        'xmlns:atom': 'http://www.w3.org/2005/Atom') do
  xml.Placemark do
    xml.name @node.name
    xml.tag! 'atom:link', href: node_url(@node)
    xml.address @node.address
    xml.description do
      xml.cdata! markdown(@node.body) if @node.body
    end

    xml.Point do
       xml.coordinates "#{@node.latitude},#{@node.longitude},0"
    end
  end
end
