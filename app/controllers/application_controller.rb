# frozen_string_literal: true

# This class is parent to all controllers in the application.
class ApplicationController < ActionController::Base
  include ExceptionHandler
  include Pundit
  include Response

  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
