# frozen_string_literal: true

module Admin
  # Administrate controller for the User model.
  class UsersController < Admin::ApplicationController
    # Wrap the update action to prevent User passwords from being
    # accidentally overwritten.
    def update
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      super
    end
  end
end
