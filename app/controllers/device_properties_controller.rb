# frozen_string_literal: true

# This controller allows management of DeviceProperty records.
class DevicePropertiesController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  after_action :verify_authorized

  def show
    @device_property = authorize DeviceProperty.find(params[:id])
  end

  def new
    @device_property =
      authorize DeviceProperty.new(device_id: params[:device_id])
  end

  def create
    @device_property = authorize DeviceProperty.new(safe_params)
    save_and_respond @device_property, :created, :create_success
  end

  def edit
    @device_property = authorize DeviceProperty.find(params[:id])
  end

  def update
    @device_property = authorize DeviceProperty.find(params[:id])
    @device_property.assign_attributes(safe_params)
    save_and_respond @device_property, :ok, :update_success
  end

  def destroy
    @device_property = authorize DeviceProperty.find(params[:id])
    destroy_and_respond @device_property, @device_property.device
  end

  private

  def safe_params
    params.require(:device_property).permit(:device_id, :key, :value)
  end
end
