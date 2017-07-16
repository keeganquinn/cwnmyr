xml.instruct!

xml << render(partial: 'host_properties/host_property.xml',
              locals: { host_property: @host_property })
