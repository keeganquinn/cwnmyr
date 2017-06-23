# This controller exposes marker data before a zone or node has been selected.
class MarkersController < ApplicationController
  after_action :verify_authorized

  def index
    @nodes = Node.all
    authorize Node

    markers = []
    @nodes.each do |node|
      if node.latitude and node.longitude
        markers << {lat: node.latitude, lng: node.longitude, marker_title: node.name, infowindow: render_to_string(partial: 'nodes/marker', locals: { node: node })}
      end
    end

    render json: markers
  end
end
