json.zone do
  json.partial! 'zones/zone.json', zone: @zone
end
json.nodes @zone.nodes, partial: 'nodes/node.json', as: :node
