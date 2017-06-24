# This controller allows viewing of Zone records.
class ZonesController < ApplicationController
  after_action :verify_authorized

  def index
    @zones = Zone.all
    authorize Zone

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render json: @zones.to_json }
      format.xml  { render xml: @zones.to_xml }
    end
  end

  def show
    @zone = Zone.find(params[:id])
    authorize @zone

    respond_to do |format|
      format.html
      format.json { render json: @zone.to_json }
      format.xml  { render xml: @zone.to_xml }
    end
  end

  def markers
    @zone = Zone.find(params[:id])
    authorize @zone

    respond_to do |format|
      format.html { redirect_to url_for(@zone) }
      format.json {
        markers = []
        @zone.nodes.each do |node|
          next unless node.latitude and node.longitude
          markers << {lat: node.latitude, lng: node.longitude, marker_title: node.name, infowindow: render_to_string(partial: 'nodes/marker.html', locals: { node: node })}
        end
        render json: markers
      }
      format.xml  { render layout: false }
    end
  end
end
