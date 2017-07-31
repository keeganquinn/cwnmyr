# This controller allows management of UserLink records.
class UserLinksController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  after_action :verify_authorized

  def show
    @user_link = authorize UserLink.find(params[:id])
  end

  def new
    @user_link = authorize UserLink.new(user_id: current_user.id)
  end

  def create
    @user_link = authorize UserLink.new(safe_params)
    save_and_respond @user_link, :created, :create_success
  end

  def edit
    @user_link = authorize UserLink.find(params[:id])
  end

  def update
    @user_link = authorize UserLink.find(params[:id])
    @user_link.assign_attributes(safe_params)
    save_and_respond @user_link, :ok, :update_success
  end

  def destroy
    @user_link = authorize UserLink.find(params[:id])
    destroy_and_respond @user_link, @user_link.user
  end

  private

  def safe_params
    params.require(:user_link).permit(:user_id, :name, :url)
  end
end
