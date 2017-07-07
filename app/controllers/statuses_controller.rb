# This controller allows viewing of Status records.
class StatusesController < ApplicationController
  after_action :verify_authorized

  def index
    @statuses = Status.all
    authorize Status
  end

  def show
    @status = Status.find(params[:id])
    authorize @status
  end
end
