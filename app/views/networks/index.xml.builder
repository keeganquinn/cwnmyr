# -*- ruby -*-
# frozen_string_literal: true

xml.instruct!

xml.networks do
  @networks.each do |network|
    xml << render(partial: 'networks/network.xml',
                  locals: { network: network })
  end
end
