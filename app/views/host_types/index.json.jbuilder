# frozen_string_literal: true

json.array! @host_types do |host_type|
  json.id host_type.to_param
  json.code host_type.code
  json.name host_type.name
end
