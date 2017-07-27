# This controller allows management of NodeLink records.
class NodeLinksController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  after_action :verify_authorized

  def index
    authorize NodeLink
    redirect_to root_path
  end

  def show
    @node_link = NodeLink.find(params[:id])
    authorize @node_link
  end

  def new
    @node_link = NodeLink.new node_id: params[:node]
    authorize @node_link
  end

  def create
    @node_link = NodeLink.new(node_link_params)
    authorize @node_link
    save_and_respond @node_link, :created, :create_success
  end

  def edit
    @node_link = NodeLink.find(params[:id])
    authorize @node_link
  end

  def update
    @node_link = NodeLink.find(params[:id])
    @node_link.assign_attributes(node_link_params)
    authorize @node_link
    save_and_respond @node_link, :ok, :update_success
  end

  def destroy
    @node_link = NodeLink.find(params[:id])
    authorize @node_link
    destroy_and_respond @node_link, @node_link.node
  end

  private

  def node_link_params
    params.require(:node_link).permit(:node_id, :name, :url)
  end
end
