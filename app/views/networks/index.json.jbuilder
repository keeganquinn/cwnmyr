# frozen_string_literal: true

json.array! @networks do |network|
  json.id network.to_param
  json.code network.code
  json.name network.name
end
