# -*- ruby -*-
# frozen_string_literal: true

xml.instruct!

xml.kml('xmlns': 'http://www.opengis.net/kml/2.2',
        'xmlns:atom': 'http://www.w3.org/2005/Atom') do
  xml << render(partial: 'nodes/node.kml', locals: { node: @node })
end
