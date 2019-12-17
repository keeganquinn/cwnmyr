# frozen_string_literal: true

module Users
  # Session controller customizations for Devise. Adds support for Turbolinks.
  class SessionsController < Devise::SessionsController
    # Wrap the new action with Turbolinks support.
    def new
      super
      response.status = :unprocessable_entity if flash[:alert]
    end
  end
end
