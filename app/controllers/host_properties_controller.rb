# This controller allows management of HostProperty records.
class HostPropertiesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  after_action :verify_authorized

  def index
    authorize HostProperty
    redirect_to root_path
  end

  def show
    @host_property = HostProperty.find(params[:id])
    authorize @host_property
  end

  def create
    @host_property = HostProperty.new(host_property_params)
    authorize @host_property
    save_and_respond @host_property, :created, :create_success
  end

  def update
    @host_property = HostProperty.find(params[:id])
    @host_property.assign_attributes(host_property_params)
    authorize @host_property
    save_and_respond @host_property, :ok, :update_success
  end

  def destroy
    @host_property = HostProperty.find(params[:id])
    authorize @host_property
    destroy_and_respond @host_property, @host_property.host
  end

  private

  def host_property_params
    params.require(:host_property).permit(:host_id, :key, :value)
  end
end
