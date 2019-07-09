# frozen_string_literal: true

xml.instruct!

xml << render(partial: 'networks/network.xml',
              locals: { network: @network })
