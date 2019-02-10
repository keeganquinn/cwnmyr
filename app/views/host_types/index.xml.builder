# frozen_string_literal: true

xml.instruct!

xml.hostTypes do
  @host_types.each do |host_type|
    xml << render(partial: 'host_types/host_type.xml',
                  locals: { host_type: host_type })
  end
end
