# frozen_string_literal: true

# This controller allows viewing of User records.
class UsersController < ApplicationController
  after_action :verify_authorized

  # Index action.
  def index
    authorize User
  end

  # Show action.
  def show
    @user = authorize User.find(params[:id])
    redirect_to root_path unless @user.visible?
  end

  # Edit action.
  def edit
    authorize User.find(params[:id])
    redirect_to edit_user_registration_path
  end

  # Update action.
  def update
    @user = authorize User.find(params[:id])
    @user.assign_attributes permitted_attributes(@user)
    save_and_respond @user, :ok, :update_success
  end

  # Confirm host mask authorization request.
  def confirm
    authorize current_user
    authorization = current_user.authorizations.find params[:id]
    authorization.confirmed_at = Time.now
    authorization.save!

    flash[:notice] = 'Authorization confirmed.'
    redirect_to edit_user_registration_path
  end

  # Revoke host mask authorization.
  def revoke
    authorize current_user
    authorization = current_user.authorizations.find params[:id]
    authorization.destroy

    flash[:notice] = 'Authorization revoked.'
    redirect_to edit_user_registration_path
  end
end
