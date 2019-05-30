# frozen_string_literal: true

xml.instruct!

xml << render(partial: 'devices/device.xml', locals: { device: @device })
