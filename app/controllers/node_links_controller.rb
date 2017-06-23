class NodeLinksController < ApplicationController
  before_filter :authenticate_user!, only: [ :create, :edit, :destroy ]
  after_action :verify_authorized

  def index
    authorize NodeLink
    redirect_to root_path
  end

  def show
    @node_link = NodeLink.find(params[:id])
    authorize @node_link

    respond_to do |format|
      format.html { redirect_to url_for(@node_link.node) }
      format.json { render json: @node_link.to_json }
      format.xml  { render xml: @node_link.to_xml }
    end
  end

  def create
    @node_link = NodeLink.new(node_link_params)
    @node_link.node = Node.find(params[:node])
    authorize @node_link

    if @node_link.save
      flash[:notice] = t(:create_success, thing: NodeLink.model_name.human)
      redirect_to url_for(@node_link.node)
    else
      @node = @node_link.node
      render 'nodes/show'
    end
  end

  def update
    @node_link = NodeLink.find(params[:id])
    authorize @node_link
    if @node_link.update_attributes(node_link_params)
      flash[:notice] = t(:update_success, thing: NodeLink.model_name.human)
      redirect_to url_for(@node_link.node)
    else
      @node = @node_link.node
      render 'nodes/show'
    end
  end

  def destroy
    node_link = NodeLink.find(params[:id])
    node = node_link.node
    authorize node_link
    node_link.destroy

    flash[:notice] = t(:delete_success, thing: NodeLink.model_name.human)
    redirect_to url_for(node)
  end

  private

  def node_link_params
    params.require(:node_link).permit(:name, :url)
  end
end
