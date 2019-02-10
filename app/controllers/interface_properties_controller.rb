# frozen_string_literal: true

# This controller allows management of InterfaceProperty records.
class InterfacePropertiesController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  after_action :verify_authorized

  def show
    @interface_property = authorize InterfaceProperty.find(params[:id])
  end

  def new
    @interface_property = authorize(
      InterfaceProperty.new(interface_id: params[:interface])
    )
  end

  def create
    @interface_property = authorize InterfaceProperty.new(safe_params)
    save_and_respond @interface_property, :created, :create_success
  end

  def edit
    @interface_property = authorize InterfaceProperty.find(params[:id])
  end

  def update
    @interface_property = authorize InterfaceProperty.find(params[:id])
    @interface_property.assign_attributes(safe_params)
    save_and_respond @interface_property, :ok, :update_success
  end

  def destroy
    @interface_property = authorize InterfaceProperty.find(params[:id])
    destroy_and_respond @interface_property, @interface_property.interface
  end

  private

  def safe_params
    params.require(:interface_property).permit(:interface_id, :key, :value)
  end
end
