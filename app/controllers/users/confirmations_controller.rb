# frozen_string_literal: true

module Users
  # Confirmation controller customizations for Devise. Adds support for
  # Turbolinks.
  class ConfirmationsController < Devise::ConfirmationsController
    def create
      super
      response.status = :unprocessable_entity if resource&.errors&.any?
    end
  end
end
