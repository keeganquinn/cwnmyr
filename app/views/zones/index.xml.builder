xml.instruct!

xml.zones do
  @zones.each do |zone|
    xml << render(partial: 'zones/zone.xml', locals: { zone: zone })
  end
end
