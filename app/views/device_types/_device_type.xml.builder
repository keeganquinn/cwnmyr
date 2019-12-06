# -*- ruby -*-
# frozen_string_literal: true

xml.deviceType do
  xml.id device_type.to_param
  xml.code device_type.code
  xml.name device_type.name
end
