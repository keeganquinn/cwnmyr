# frozen_string_literal: true

# This controller allows viewing of User records.
class UsersController < ApplicationController
  after_action :verify_authorized

  def index
    authorize User
  end

  def show
    @user = authorize User.find(params[:id])
    redirect_to root_path unless @user.visible?
  end

  def edit
    authorize User.find(params[:id])
    redirect_to edit_user_registration_path
  end

  def update
    @user = authorize User.find(params[:id])
    @user.assign_attributes(safe_params)
    save_and_respond @user, :ok, :update_success, :edit
  end

  private

  def safe_params
    params.require(:user).permit(:name, :body)
  end
end
