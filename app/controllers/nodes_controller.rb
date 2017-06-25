require_dependency 'dot_diskless'

# This controller facilitates interaction with Nodes.
class NodesController < ApplicationController
  before_action :authenticate_user!, except: [
    :comment_feed, :log_feed, :graph, :index, :show, :markers, :wl
  ]
  after_action :verify_authorized

  def index
    authorize Node
    redirect_to root_path
  end

  def show
    @node = Node.find(params[:id])
    authorize @node

    respond_to do |format|
      format.html
      format.json { render json: @node.to_json }
      format.xml  { render xml: @node.to_xml }
    end
  end

  def new
    @node = Node.new
    authorize @node
    @node.zone = Zone.find(params[:zone])
    @node.user = current_user
  end

  def create
    @node = Node.new(node_params)
    @node.zone = Zone.find(params[:zone])
    @node.user = current_user
    authorize @node

    if @node.save
      flash[:notice] = t(:create_success, thing: Node.model_name.human)
      redirect_to url_for(@node)
    else
      render :new
    end
  end

  def edit
    @node = Node.find(params[:id])
    authorize @node
  end

  def update
    @node = Node.find(params[:id])
    authorize @node
    if @node.update_attributes(node_params)
      flash[:notice] = t(:update_success, thing: Node.model_name.human)
      redirect_to url_for(@node)
    else
      render :edit
    end
  end

  def destroy
    node = Node.find(params[:id])
    zone = node.zone
    authorize node
    node.destroy

    flash[:notice] = t(:delete_success, thing: Node.model_name.human)
    redirect_to url_for(zone)
  end

  def graph
    @node = Node.find(params[:id])
    authorize @node

    send_data @node.graph.to_png, type: 'image/png', disposition: 'inline'
  end

  def markers
    @node = Node.find(params[:id])
    authorize @node

    respond_to do |format|
      format.html { redirect_to url_for(@node) }
      format.json { render json: [{lat: @node.latitude, lng: @node.longitude, marker_title: @node.name, infowindow: render_to_string(partial: 'marker.html', locals: { node: @node })}] }
      format.kml  { render 'markers.xml', layout: false }
    end
  end

  def wl
    @node = Node.find(params[:id])
    authorize @node

    render layout: false
  end

  private

  def node_params
    params.require(:node).permit(:code, :name, :status_id, :body, :address, :hours, :notes)
  end
end
