json.array! @interface_types do |interface_type|
  json.id interface_type.to_param
  json.code interface_type.code
  json.name interface_type.name
end
