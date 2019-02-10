# frozen_string_literal: true

# This controller facilitates interaction with Nodes.
class NodesController < ApplicationController
  include Paperclip::Storage::Database::ControllerClassMethods
  downloads_files_for :node, :logo

  before_action :authenticate_user!, except: %i[show graph logos]
  after_action :verify_authorized, except: %i[logos]

  def show
    @node = authorize Node.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @node = authorize Node.find_by_code(params[:id])
    raise unless @node

    redirect_to node_path(@node)
  end

  def new
    @node = authorize Node.new(user_id: current_user.id, zone_id: params[:zone])
  end

  def create
    @node = authorize Node.new(safe_params)
    save_and_respond @node, :created, :create_success
  end

  def edit
    @node = authorize Node.find(params[:id])
  end

  def update
    @node = authorize Node.find(params[:id])
    @node.assign_attributes(safe_params)
    save_and_respond @node, :ok, :update_success
  end

  def destroy
    @node = authorize Node.find(params[:id])
    destroy_and_respond @node, @node.zone
  end

  def graph
    @node = authorize Node.find(params[:id])

    respond_to do |format|
      format.png do
        send_data @node.graph.to_png, type: 'image/png', disposition: 'inline'
      end
      format.any { redirect_to format: :png }
    end
  end

  private

  def safe_params
    params.require(:node).permit(
      :user_id, :zone_id, :code, :name, :status_id, :body, :address,
      :hours, :notes, :logo
    )
  end
end
