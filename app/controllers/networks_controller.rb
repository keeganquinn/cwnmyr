# frozen_string_literal: true

# This controller allows viewing of Network records.
class NetworksController < ApplicationController
  after_action :verify_authorized

  def index
    @networks = Network.all
    authorize Network
  end

  def show
    @network = authorize Network.find(params[:id])
  end
end
