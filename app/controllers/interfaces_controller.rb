# This controller allows management of Interface records.
class InterfacesController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  after_action :verify_authorized

  def show
    @interface = Interface.find(params[:id])
    authorize @interface
  end

  def new
    @interface = Interface.new host_id: params[:host]
    authorize @interface
  end

  def create
    @interface = Interface.new(interface_params)
    authorize @interface
    save_and_respond @interface, :created, :create_success
  end

  def edit
    @interface = Interface.find(params[:id])
    authorize @interface
  end

  def update
    @interface = Interface.find(params[:id])
    @interface.assign_attributes(interface_params)
    authorize @interface
    save_and_respond @interface, :ok, :update_success
  end

  def destroy
    @interface = Interface.find(params[:id])
    authorize @interface
    destroy_and_respond @interface, @interface.host
  end

  private

  def interface_params
    params.require(:interface).permit(
      :host_id, :code, :name, :interface_type_id, :status_id, :body,
      :address_ipv4, :address_ipv6, :address_mac,
      :latitude, :longitude, :altitude,
      :essid, :security_psk, :channel, :tx_power, :rx_sensitivity,
      :cable_loss, :antenna_gain, :beamwidth_h, :beamwidth_v,
      :azimuth, :elevation, :polarity
    )
  end
end
