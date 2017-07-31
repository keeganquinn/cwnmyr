# This controller allows viewing of Interface Type records.
class InterfaceTypesController < ApplicationController
  after_action :verify_authorized

  def index
    @interface_types = InterfaceType.all
    authorize InterfaceType
  end

  def show
    @interface_type = authorize InterfaceType.find(params[:id])
  end
end
