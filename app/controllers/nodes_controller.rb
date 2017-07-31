# This controller facilitates interaction with Nodes.
class NodesController < ApplicationController
  before_action :authenticate_user!, except: %i[show graph]
  after_action :verify_authorized

  def show
    @node = Node.find(params[:id])
    authorize @node
  end

  def new
    @node = Node.new
    @node.zone = Zone.find(params[:zone])
    @node.user = current_user
    authorize @node
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

    respond_to do |format|
      format.png do
        send_data @node.graph.to_png, type: 'image/png', disposition: 'inline'
      end
      format.any { redirect_to format: :png }
    end
  end

  private

  def node_params
    params.require(:node).permit(
      :code, :name, :status_id, :body, :address, :hours, :notes
    )
  end
end
