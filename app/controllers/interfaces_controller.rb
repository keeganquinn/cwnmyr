# This controller allows management of Interface records.
class InterfacesController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  after_action :verify_authorized

  def show
    @interface = authorize Interface.find(params[:id])
  end

  def new
    @interface = authorize Interface.new(host_id: params[:host_id])
  end

  def create
    @interface = authorize Interface.new(safe_params)
    save_and_respond @interface, :created, :create_success
  end

  def edit
    @interface = authorize Interface.find(params[:id])
  end

  def update
    @interface = authorize Interface.find(params[:id])
    @interface.assign_attributes(safe_params)
    save_and_respond @interface, :ok, :update_success
  end

  def destroy
    @interface = authorize Interface.find(params[:id])
    destroy_and_respond @interface, @interface.host
  end

  private

  def safe_params
    params.require(:interface).permit(
      :host_id, :code, :name, :interface_type_id, :body,
      :address_ipv4, :address_ipv6, :address_mac,
      :latitude, :longitude, :altitude,
      :essid, :security_psk, :channel, :tx_power, :rx_sensitivity,
      :cable_loss, :antenna_gain, :beamwidth_h, :beamwidth_v,
      :azimuth, :elevation, :polarity
    )
  end
end
