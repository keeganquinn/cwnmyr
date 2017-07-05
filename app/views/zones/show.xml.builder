xml.instruct!

xml << render(partial: 'zones/zone.xml', locals: { zone: @zone })
