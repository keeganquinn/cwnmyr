# frozen_string_literal: true

module Admin
  # Administrate controller for the User model.
  class UsersController < Admin::ApplicationController
    def update
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      super
    end
  end
end
