xml.instruct!

xml << render(partial: 'hosts/host.xml', locals: { host: @host })
