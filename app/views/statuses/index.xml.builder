xml.instruct!

xml.statuses do
  @statuses.each do |status|
    xml << render(partial: 'statuses/status.xml', locals: { status: status })
  end
end
