# frozen_string_literal: true

xml.instruct!

xml.deviceTypes do
  @device_types.each do |device_type|
    xml << render(partial: 'device_types/device_type.xml',
                  locals: { device_type: device_type })
  end
end
