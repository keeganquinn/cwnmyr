module Admin
  # Parent class for Administrate controllers.
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin

    def authenticate_admin
      redirect_to new_user_session_path, alert: t(:access_denied) \
        unless current_user&.admin?
    end

    def records_per_page
      params[:per_page] || 50
    end
  end
end
