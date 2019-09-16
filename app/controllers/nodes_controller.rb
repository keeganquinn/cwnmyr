# frozen_string_literal: true

# This controller facilitates interaction with Nodes.
class NodesController < ApplicationController
  before_action :authenticate_user!, except: %i[show graph]
  after_action :verify_authorized

  def show
    @node = authorize Node.find(params[:id])
    serve_image if params[:format] == 'png'
  rescue ActiveRecord::RecordNotFound
    @node = authorize Node.find_by_code(params[:id])
    raise unless @node

    redirect_to node_path(@node)
  end

  def new
    @node = authorize Node.new(user_id: current_user.id)
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
    destroy_and_respond @node, browse_path
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

  def blob
    @node.logo.blob
  end

  def serve_image
    return head(:not_found) unless @node.logo.attached?

    expires_in 1.year, public: true
    send_data blob.service.download(blob.key),
              type: blob.content_type, disposition: 'inline'
  end

  def safe_params
    params.require(:node).permit(
      :user_id, :code, :name, :status_id, :group_id, :contact_id, :body,
      :address, :hours, :notes, :live_date, :website, :rss, :twitter, :wiki,
      :logo,
      contact_attributes: %i[id name hidden email phone notes user_id _destroy]
    )
  end
end
