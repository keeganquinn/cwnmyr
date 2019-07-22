# frozen_string_literal: true

module Users
  # Unlock controller customizations for Devise. Adds support for Turbolinks.
  class UnlocksController < Devise::UnlocksController
    def create
      super
      response.status = :unprocessable_entity unless resource&.persisted?
    end
  end
end
