# This controller allows viewing of Zone records.
class ZonesController < ApplicationController
  after_action :verify_authorized

  def index
    @zones = Zone.all
    authorize Zone

    respond_to do |format|
      format.html { redirect_to visitors_path }
      format.json { render :json => @zones.to_json }
      format.xml  { render :xml => @zones.to_xml }
    end
  end

  def show
    @zone = Zone.find(params[:id])
    authorize @zone

    respond_to do |format|
      format.html
      format.json { render :json => @zone.to_json }
      format.xml  { render :xml => @zone.to_xml }
    end
  end

  def markers
    @zone = Zone.find(params[:id])
    authorize @zone

    markers = []
    @zone.nodes.each do |node|
      if node.latitude and node.longitude
        markers << {'lat': node.latitude, 'lng': node.longitude}
      end
    end

    render :json => markers
  end
end
