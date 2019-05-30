# frozen_string_literal: true

xml.instruct!

xml << render(partial: 'device_properties/device_property.xml',
              locals: { device_property: @device_property })
