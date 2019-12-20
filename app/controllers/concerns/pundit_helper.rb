# frozen_string_literal: true

# Extends the ApplicationController to add Pundit for authorization.
module PunditHelper
  extend ActiveSupport::Concern

  included do
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized
    flash[:alert] = 'Access denied.'
    redirect_to request.referrer || root_path
  end
end
