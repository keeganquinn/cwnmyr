xml.instruct!

xml << render(partial: 'host_types/host_type.xml',
              locals: { host_type: @host_type })
