xml.instruct!

xml.interfaceTypes do
  @interface_types.each do |interface_type|
    xml << render(partial: 'interface_types/interface_type.xml',
                  locals: { interface_type: interface_type })
  end
end
