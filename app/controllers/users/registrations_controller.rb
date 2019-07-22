# frozen_string_literal: true

module Users
  # Registration controller customizations for Devise. Adds support for
  # Turbolinks.
  class RegistrationsController < Devise::RegistrationsController
    def create
      super
      response.status = :unprocessable_entity if resource&.errors&.any?
    end

    def update
      super
      response.status = :unprocessable_entity if resource&.errors&.any?
    end
  end
end
