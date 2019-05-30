# frozen_string_literal: true

# This controller allows viewing of Device Type records.
class DeviceTypesController < ApplicationController
  after_action :verify_authorized

  def index
    @device_types = DeviceType.all
    authorize DeviceType
  end

  def show
    @device_type = authorize DeviceType.find(params[:id])
  end
end
