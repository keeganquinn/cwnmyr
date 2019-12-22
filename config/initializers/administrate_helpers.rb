# frozen_string_literal: true

Rails.application.config.to_prepare do
  Administrate::ApplicationController.helper Rails.application.helpers
end
