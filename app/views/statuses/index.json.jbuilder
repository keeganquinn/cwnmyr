# frozen_string_literal: true

json.statuses @statuses, partial: 'statuses/status.json', as: :status
