# frozen_string_literal: true

xml.instruct!

xml << render(partial: 'hosts/host.xml', locals: { host: @host })
