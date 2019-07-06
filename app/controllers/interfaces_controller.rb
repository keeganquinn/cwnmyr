# frozen_string_literal: true

# This controller allows management of Interface records.
class InterfacesController < ApplicationController
  after_action :verify_authorized

  def index
    authorize Interface
    redirect_to browse_path
  end

  def show
    @interface = authorize Interface.find(params[:id])
    redirect_to @interface&.device || browse_path
  end
end
