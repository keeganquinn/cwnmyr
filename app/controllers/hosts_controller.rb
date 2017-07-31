# This controller allows management of Host records.
class HostsController < ApplicationController
  before_action :authenticate_user!, except: %i[show graph]
  after_action :verify_authorized

  def show
    @host = authorize Host.find(params[:id])
  end

  def new
    @host = authorize Host.new(node_id: params[:node])
  end

  def create
    @host = authorize Host.new(safe_params)
    save_and_respond @host, :created, :create_success
  end

  def edit
    @host = authorize Host.find(params[:id])
  end

  def update
    @host = authorize Host.find(params[:id])
    @host.assign_attributes(safe_params)
    save_and_respond @host, :ok, :update_success
  end

  def destroy
    @host = authorize Host.find(params[:id])
    destroy_and_respond @host, @host.node
  end

  def graph
    @host = authorize Host.find(params[:id])

    respond_to do |format|
      format.png do
        send_data @host.graph.to_png, type: 'image/png', disposition: 'inline'
      end
      format.any { redirect_to format: :png }
    end
  end

  private

  def safe_params
    params.require(:host).permit(:node_id, :name, :status_id)
  end
end
