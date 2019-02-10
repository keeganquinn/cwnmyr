# frozen_string_literal: true

xml.hostProperty do
  xml.id host_property.to_param
  xml.key host_property.key
  xml.value host_property.value
end
