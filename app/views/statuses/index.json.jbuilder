json.array! @statuses do |status|
  json.id status.to_param
  json.code status.code
  json.name status.name
end
