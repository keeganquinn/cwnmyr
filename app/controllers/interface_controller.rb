class InterfaceController < ApplicationController
  before_filter :login_required, :except => [ :map, :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @interface = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname]).interfaces.find_by_code(params[:code])

    @page_heading = 'Interface: ' + @interface.code
  end

  def map
    @interface = Interface.find(params[:id])

    @page_heading = 'Interface map: ' + @interface.code

    if point = @interface.average_point
      marker = GMarker.new([point[:latitude], point[:longitude]],
                           :title => @interface.code,
                           :info_window => @interface.code)

      @map = GMap.new('interface_map')
      @map.overlay_init Clusterer.new([marker])
      @map.center_zoom_init marker.point, 18
    end
  end

  def new
    @interface = Interface.new params[:interface]
    @interface.host = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname])

    @page_heading = 'New interface'

    return unless request.post?

    if @interface.save
      flash[:notice] = 'Interface was successfully created.'

      redirect_to(:controller => 'host',
                  :action => 'show',
                  :node_code => @interface.host.node.code,
                  :hostname => @interface.host.name)
    end
  end

  def edit
    @interface = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname]).interfaces.find_by_code(params[:code])

    @page_heading = 'Interface: ' + @interface.code

    return unless request.post?

    if @interface.update_attributes(params[:interface])
      flash[:notice] = 'Interface was successfully updated.'

      redirect_to(:action => 'show', 
                  :node_code => @interface.host.node.code,
                  :hostname => @interface.host.name,
                  :code => @interface.code)
    end
  end

  def destroy
    host = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname])
    interface = host.interfaces.find_by_code(params[:code])
    interface.destroy

    flash[:notice] = 'Interface was successfully destroyed.'

    redirect_to(:controller => 'host',
                :action => 'show',
                :node_code => host.node.code,
                :hostname => host.name)
  end

  def wireless
    @interface = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname]).interfaces.find_by_code(params[:code])
    if @interface.wireless_interface
      @wireless_interface = @interface.wireless_interface
    else
      @wireless_interface = WirelessInterface.new params[:wireless_interface]
      @wireless_interface.interface = @interface
    end

    @page_heading = 'Wireless interface properties: ' + @interface.code

    return unless request.method == :post

    if @interface.wireless_interface
      if @wireless_interface.update_attributes(params[:wireless_interface])
        flash[:notice] = 'Interface wireless properties successfully set.'

        redirect_to(:action => 'show',
                    :node_code => @interface.host.node.code,
                    :hostname => @interface.host.name,
                    :code => @interface.code)
      end
    else
      if @wireless_interface.save
        flash[:notice] = 'Interface wireless properties successfully set.'

        redirect_to(:action => 'show',
                    :node_code => @interface.host.node.code,
                    :hostname => @interface.host.name,
                    :code => @interface.code)
      end
    end
  end
end
