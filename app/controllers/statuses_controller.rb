# frozen_string_literal: true

# This controller allows viewing of Status records.
class StatusesController < ApplicationController
  after_action :verify_authorized

  # Index action.
  def index
    @statuses = Status.all
    authorize Status
  end

  # Show action.
  def show
    @status = authorize Status.find(params[:id])
  end
end
