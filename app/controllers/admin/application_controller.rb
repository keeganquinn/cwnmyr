# frozen_string_literal: true

module Admin
  # Parent class for Administrate controllers.
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin

    # Authenticate the current User as an administrator.
    def authenticate_admin
      redirect_to new_user_session_path, alert: t(:access_denied) \
        unless current_user&.admin?
    end

    # Number of records to display per page.
    def records_per_page
      params[:per_page] || 50
    end
  end
end
