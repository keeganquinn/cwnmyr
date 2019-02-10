# frozen_string_literal: true

# This controller allows viewing of Status records.
class StatusesController < ApplicationController
  after_action :verify_authorized

  def index
    @statuses = Status.all
    authorize Status
  end

  def show
    @status = authorize Status.find(params[:id])
  end
end
