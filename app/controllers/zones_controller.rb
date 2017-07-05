# This controller allows viewing of Zone records.
class ZonesController < ApplicationController
  after_action :verify_authorized

  def index
    @zones = Zone.all
    authorize Zone

    respond_to do |format|
      format.json
      format.xml
      format.any { redirect_to root_path }
    end
  end

  def show
    @zone = Zone.find(params[:id])
    authorize @zone
  end
end
