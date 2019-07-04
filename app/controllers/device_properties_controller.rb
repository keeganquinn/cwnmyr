# frozen_string_literal: true

# This controller allows management of DeviceProperty records.
class DevicePropertiesController < ApplicationController
  after_action :verify_authorized

  def index
    authorize DeviceProperty
    redirect_to browse_path
  end

  def show
    @device_property = authorize DeviceProperty.find(params[:id])
    redirect_to @device_property.device
  end
end
