class HostsController < ApplicationController
  before_filter :authenticate_user!, only: [ :create, :edit, :destroy ]
  after_action :verify_authorized

  def index
    authorize Host
    redirect_to root_path
  end

  def show
    @host = Host.find(params[:id])
    authorize @host

    respond_to do |format|
      format.html { redirect_to url_for(@host.node) }
      format.json { render json: @host.to_json }
      format.xml  { render xml: @host.to_xml }
    end
  end

  def create
    @host = Host.new(host_params)
    @host.node = Node.find(params[:node])
    authorize @host

    if @host.save
      flash[:notice] = t(:create_success, thing: Host.model_name.human)
      redirect_to url_for(@host.node)
    else
      @node = @host.node
      render 'nodes/show'
    end
  end

  def update
    @host = Host.find(params[:id])
    authorize @host
    if @host.update_attributes(host_params)
      flash[:notice] = t(:update_success, thing: Host.model_name.human)
      redirect_to url_for(@host.node)
    else
      @node = @host.node
      render 'nodes/show'
    end
  end

  def destroy
    host = Host.find(params[:id])
    node = host.node
    authorize host
    host.destroy

    flash[:notice] = t(:delete_success, thing: Host.model_name.human)
    redirect_to url_for(node)
  end

  def graph
    host = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname])

    send_data(host.graph.to_png,
              :type => 'image/png', :disposition => 'inline')
  end

  def feed
    @host = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname])
    render :layout => false
  end

  private

  def host_params
    params.require(:host).permit(:name, :status_id)
  end
end
