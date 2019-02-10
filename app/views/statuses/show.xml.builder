# frozen_string_literal: true

xml.instruct!

xml << render(partial: 'statuses/status.xml', locals: { status: @status })
