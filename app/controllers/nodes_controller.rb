# This controller facilitates interaction with Nodes.
class NodesController < ApplicationController
  before_action :authenticate_user!, :except => [
    :comment_feed, :log_feed, :graph, :show, :wl
  ]
  after_action :verify_authorized

  def show
    @node = Node.find(params[:id])
    authorize @node

    markers = []
    @node.hosts.each do |host|
      if point = host.average_point
        markers << GMarker.new([point[:latitude], point[:longitude]],
                               :title => host.name,
                               :info_window => "<a href=\"" +
                                   url_for(:controller => 'host',
                                           :action => 'show',
                                           :node_code => @node.code,
                                           :hostname => host.name) +
                                   "\">" + host.name + "</a>")
      end
    end

    unless markers.empty?
      @map = GMap.new('node_map')
      @map.overlay_init Clusterer.new(markers)
      @map.center_zoom_init markers.first.point, 15
    end

    respond_to do |format|
      format.html
      format.json { render :json => @node.to_json }
      format.xml  { render :xml => @node.to_xml }
    end
  end

  def markers
    @node = Node.find(params[:id])
    authorize @node

    render :json => [{'lat': @node.latitude, 'lng': @node.longitude}]
  end

  def new
    @node = Node.new
    authorize @node
    @node.zone = Zone.find(params[:zone])
    @node.user = current_user
  end

  def create
    @node = Node.new(node_params)
    authorize @node
    @node.zone = Zone.find(params[:zone])
    @node.user = current_user

    if @node.save
      flash[:notice] = t('.success')
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
      flash[:notice] = t('.success')
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

    flash[:notice] = t('.success')
    redirect_to url_for(zone)
  end

  def graph
    node = Node.find_by_code(params[:code])

    unless logged_in? or node.expose?
      redirect_to(:controller => 'welcome') and return
    end

    send_data(node.graph.to_png,
              :type => 'image/png', :disposition => 'inline')
  end

  def comment_feed
    @node = Node.find_by_code(params[:code])

    unless logged_in? or @node.expose?
      redirect_to(:controller => 'welcome') and return
    end

    render :layout => false
  end

  def log_feed
    @node = Node.find_by_code(params[:code])

    unless logged_in? or @node.expose?
      redirect_to(:controller => 'welcome') and return
    end

    render :layout => false
  end

  def wl
    @node = Node.find_by_code(params[:code])

    unless logged_in? or @node.expose?
      redirect_to(:controller => 'welcome') and return
    end

    render :layout => false
  end

  private

  def node_params
    params.require(:node).permit(:code, :name, :status_id, :body, :address)
  end
end
