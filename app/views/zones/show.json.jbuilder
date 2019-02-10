# frozen_string_literal: true

json.zone do
  json.partial! 'zones/zone.json', zone: @zone
  json.statuses Status.all do |status|
    json.partial! 'statuses/status.json', status: status
    json.nodes @zone.nodes.where(status: status),
               partial: 'nodes/node.json', as: :node
  end
end
