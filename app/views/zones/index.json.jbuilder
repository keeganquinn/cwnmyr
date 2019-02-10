# frozen_string_literal: true

json.array! @zones do |zone|
  json.id zone.to_param
  json.code zone.code
  json.name zone.name
end
