# frozen_string_literal: true

module Users
  # Registration controller customizations for Devise. Adds support for
  # Turbolinks.
  class RegistrationsController < Devise::RegistrationsController
    # Wrap the create action with Turbolinks support.
    def create
      super
      response.status = :unprocessable_entity if resource&.errors&.any?
    end

    # Wrap the update action with Turbolinks support.
    def update
      super
      response.status = :unprocessable_entity if resource&.errors&.any?
    end
  end
end
