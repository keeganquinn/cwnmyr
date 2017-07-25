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

  def conf
    @zone = Zone.find(params[:id])
    authorize @zone
    render conf_tpl
  end

  protected

  def conf_tpl
    "conf/#{params[:svc].tr('^A-Za-z0-9_', '')}.text"
  end
end
