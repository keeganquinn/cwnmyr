# frozen_string_literal: true

json.array! @device_types do |device_type|
  json.id device_type.to_param
  json.code device_type.code
  json.name device_type.name
end
