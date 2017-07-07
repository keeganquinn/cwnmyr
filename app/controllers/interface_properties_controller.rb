# This controller allows management of InterfaceProperty records.
class InterfacePropertiesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  after_action :verify_authorized

  def index
    authorize InterfaceProperty
    redirect_to root_path
  end

  def show
    @interface_property = InterfaceProperty.find(params[:id])
    authorize @interface_property
  end

  def create
    @interface_property = InterfaceProperty.new(interface_property_params)
    authorize @interface_property
    save_and_respond @interface_property, :created, :create_success
  end

  def update
    @interface_property = InterfaceProperty.find(params[:id])
    @interface_property.assign_attributes(interface_property_params)
    authorize @interface_property
    save_and_respond @interface_property, :ok, :update_success
  end

  def destroy
    @interface_property = InterfaceProperty.find(params[:id])
    authorize @interface_property
    destroy_and_respond @interface_property, @interface_property.interface
  end

  private

  def interface_property_params
    params.require(:interface_property).permit(:interface_id, :key, :value)
  end
end
