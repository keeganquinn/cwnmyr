xml.instruct!

xml << render(partial: 'statuses/status.xml', locals: { status: @status })
