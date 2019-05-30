# frozen_string_literal: true

xml.deviceProperty do
  xml.id device_property.to_param
  xml.key device_property.key
  xml.value device_property.value
end
