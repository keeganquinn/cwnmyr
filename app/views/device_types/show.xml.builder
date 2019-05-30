# frozen_string_literal: true

xml.instruct!

xml << render(partial: 'device_types/device_type.xml',
              locals: { device_type: @device_type })
