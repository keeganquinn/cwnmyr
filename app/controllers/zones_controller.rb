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
    @zone = authorize Zone.find(params[:id])
  end

  def conf
    @zone = authorize Zone.find(params[:id])
    render "conf/#{svc_param}.text"
  end

  protected

  def svc_param
    params[:svc].tr('^A-Za-z0-9_', '')
  end
end
