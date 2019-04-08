# frozen_string_literal: true

module Ahoy
  class Store < Ahoy::DatabaseStore
  end
end

# set to true for JavaScript tracking
Ahoy.api = true

# better user agent parsing
Ahoy.user_agent_parser = :device_detector

# better bot detection
Ahoy.bot_detection_version = 2
