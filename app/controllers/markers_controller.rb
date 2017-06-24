# This controller exposes marker data before a zone or node has been selected.
class MarkersController < ApplicationController
  after_action :verify_authorized

  def index
    @nodes = Node.all
    authorize Node

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json {
        markers = []
        @nodes.each do |node|
          next unless node.latitude and node.longitude
          markers << {lat: node.latitude, lng: node.longitude, marker_title: node.name, infowindow: render_to_string(partial: 'nodes/marker.html', locals: { node: node })}
        end
        render json: markers
      }
      format.xml  { render layout: false }
    end
  end
end
