# This controller allows management of NodeLink records.
class NodeLinksController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  after_action :verify_authorized

  def show
    @node_link = authorize NodeLink.find(params[:id])
  end

  def new
    @node_link = authorize NodeLink.new(node_id: params[:node])
  end

  def create
    @node_link = authorize NodeLink.new(safe_params)
    save_and_respond @node_link, :created, :create_success
  end

  def edit
    @node_link = authorize NodeLink.find(params[:id])
  end

  def update
    @node_link = authorize NodeLink.find(params[:id])
    @node_link.assign_attributes(safe_params)
    save_and_respond @node_link, :ok, :update_success
  end

  def destroy
    @node_link = authorize NodeLink.find(params[:id])
    destroy_and_respond @node_link, @node_link.node
  end

  private

  def safe_params
    params.require(:node_link).permit(:node_id, :name, :url)
  end
end
