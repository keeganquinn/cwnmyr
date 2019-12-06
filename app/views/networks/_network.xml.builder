# -*- ruby -*-
# frozen_string_literal: true

xml.network do
  xml.id network.to_param
  xml.code network.code
  xml.name network.name
end
