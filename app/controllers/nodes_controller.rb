# frozen_string_literal: true

# This controller facilitates interaction with Nodes.
class NodesController < ApplicationController
  before_action :authenticate_user!, except: %i[show graph]
  after_action :verify_authorized

  # Show action.
  def show
    @node = authorize Node.find(params[:id])
    serve_image if params[:format] == 'png'
  rescue ActiveRecord::RecordNotFound
    @node = authorize Node.find_by_code(params[:id])
    raise unless @node

    redirect_to node_path(@node)
  end

  # New action.
  def new
    @node = authorize Node.new(user_id: current_user.id)
  end

  # Create action.
  def create
    @node = authorize Node.new(permitted_attributes(Node))
    save_and_respond @node, :created, :create_success
  end

  # Edit action.
  def edit
    @node = authorize Node.find(params[:id])
  end

  # Update action.
  def update
    @node = authorize Node.find(params[:id])
    @node.assign_attributes permitted_attributes(@node)
    save_and_respond @node, :ok, :update_success
  end

  # Destroy action.
  def destroy
    @node = authorize Node.find(params[:id])
    destroy_and_respond @node, browse_path
  end

  # Graph action.
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
end
