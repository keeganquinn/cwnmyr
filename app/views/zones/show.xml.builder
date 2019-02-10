# frozen_string_literal: true

xml.instruct!

xml << render(partial: 'zones/zone.xml', locals: { zone: @zone })
