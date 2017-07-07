# This controller allows viewing of Host Type records.
class HostTypesController < ApplicationController
  after_action :verify_authorized

  def index
    @host_types = HostType.all
    authorize HostType
  end

  def show
    @host_type = HostType.find(params[:id])
    authorize @host_type
  end
end
