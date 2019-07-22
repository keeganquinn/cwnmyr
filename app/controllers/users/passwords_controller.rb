# frozen_string_literal: true

module Users
  # Password controller customizations for Devise. Adds support for Turbolinks.
  class PasswordsController < Devise::PasswordsController
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
