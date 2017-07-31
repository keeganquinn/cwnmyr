# This controller allows management of HostProperty records.
class HostPropertiesController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  after_action :verify_authorized

  def show
    @host_property = authorize HostProperty.find(params[:id])
  end

  def create
    @host_property = authorize HostProperty.new(safe_params)
    save_and_respond @host_property, :created, :create_success
  end

  def update
    @host_property = authorize HostProperty.find(params[:id])
    @host_property.assign_attributes(safe_params)
    save_and_respond @host_property, :ok, :update_success
  end

  def destroy
    @host_property = authorize HostProperty.find(params[:id])
    destroy_and_respond @host_property, @host_property.host
  end

  private

  def safe_params
    params.require(:host_property).permit(:host_id, :key, :value)
  end
end
