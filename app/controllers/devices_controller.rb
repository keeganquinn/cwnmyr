# frozen_string_literal: true

# This controller allows management of Device records.
class DevicesController < ApplicationController
  before_action :authenticate_user!,
                except: %i[index show build_config conf graph]

  # Index action.
  def index
    redirect_to browse_path
  end

  # Show action.
  def show
    @device = authorize Device.find(params[:id])
    serve_image if params[:format] == 'jpg'
  end

  # New action.
  def new
    @device = authorize Device.new(user_id: current_user.id)
  end

  # Create action.
  def create
    @device = authorize Device.new(permitted_attributes(Device))
    save_and_respond @device, :created, :create_success
  end

  # Edit action.
  def edit
    @device = authorize Device.find(params[:id])
  end

  # Update action.
  def update
    @device = authorize Device.find(params[:id])
    @device.assign_attributes permitted_attributes(@device)
    save_and_respond @device, :ok, :update_success
  end

  # Destroy action.
  def destroy
    @device = authorize Device.find(params[:id])
    destroy_and_respond @device, @device.node
  end

  # Build action.
  def build
    @device = authorize Device.find(params[:id])
    try_build if @device.can_build?
    redirect_to @device
  end

  # Build configuration action.
  def build_config
    show
    render plain: @device.build_config.delete("\r")
  end

  # Device configuration action.
  def conf
    show
  end

  # Graph action.
  def graph
    @device = authorize Device.find(params[:id])

    respond_to do |format|
      format.png do
        send_data @device.graph.to_png, type: 'image/png', disposition: 'inline'
      end
      format.any { redirect_to format: :png }
    end
  end

  private

  def blob
    @device.image.blob
  end

  def serve_image
    return head(:not_found) unless @device.image.attached?

    expires_in 1.year, public: true
    send_data blob.service.download(blob.key),
              type: blob.content_type, disposition: 'inline'
  end

  def try_build
    if @device&.device_type&.build_provider&.build(@device)
      flash[:notice] = 'Build started.'
    else
      flash[:warning] = 'Build not available.'
    end
  end
end
