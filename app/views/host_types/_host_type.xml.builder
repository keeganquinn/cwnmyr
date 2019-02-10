# frozen_string_literal: true

xml.hostType do
  xml.id host_type.to_param
  xml.code host_type.code
  xml.name host_type.name
end
