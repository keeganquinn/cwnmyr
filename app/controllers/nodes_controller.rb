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
  end

  def new
    @node = Node.new(params[:node])
    @node.zone = Zone.find_by_code params[:zone_code]
    @node.user = current_user

    @page_heading = 'New node'

    unless request.post?
      @node.country = AH_DEFAULT_COUNTRY
      @node.state = AH_DEFAULT_STATE
      @node.city = AH_DEFAULT_CITY
      return
    end

    if @node.save
      flash[:notice] = 'Node was successfully created.'

      redirect_to(:controller => 'zone',
                  :action => 'show',
                  :code => @node.zone.code)
    end
  end

  def edit
    @node = Node.find_by_code(params[:code])

    @page_heading = 'Node: ' + @node.name

    return unless request.post?

    if @node.update_attributes(params[:node])
      flash[:notice] = 'Node was successfully updated.'
      redirect_to :action => 'show', :code => @node.code
    end
  end

  def destroy
    node = Node.find_by_code(params[:code])
    zone = node.zone
    node.destroy

    flash[:notice] = 'Node was successfully destroyed.'

    redirect_to(:controller => 'zone',
                :action => 'show',
                :code => zone.code)
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
end
