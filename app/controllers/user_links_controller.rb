# This controller allows management of UserLink records.
class UserLinksController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  after_action :verify_authorized

  def index
    authorize UserLink
    redirect_to root_path
  end

  def show
    @user_link = UserLink.find(params[:id])
    authorize @user_link
  end

  def create
    @user_link = UserLink.new(user_link_params)
    authorize @user_link
    save_and_respond @user_link, :created, :create_success
  end

  def update
    @user_link = UserLink.find(params[:id])
    @user_link.assign_attributes(user_link_params)
    authorize @user_link
    save_and_respond @user_link, :ok, :update_success
  end

  def destroy
    @user_link = UserLink.find(params[:id])
    authorize @user_link
    destroy_and_respond @user_link, @user_link.user
  end

  private

  def user_link_params
    params.require(:user_link).permit(:user_id, :name, :url)
  end
end
