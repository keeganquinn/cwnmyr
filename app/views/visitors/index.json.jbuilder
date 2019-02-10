# frozen_string_literal: true

json.statuses Status.all do |status|
  json.partial! 'statuses/status.json', status: status
  json.nodes status.nodes, partial: 'nodes/node.json', as: :node
end
