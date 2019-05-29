# frozen_string_literal: true

module Ahoy
  # Event model for Ahoy.
  class Event < ApplicationRecord
    include Ahoy::QueryMethods

    self.table_name = 'ahoy_events'

    belongs_to :visit
    belongs_to :user, optional: true
  end
end
