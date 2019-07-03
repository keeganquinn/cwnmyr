# frozen_string_literal: true

# This controller allows management of NodeLink records.
class NodeLinksController < ApplicationController
  after_action :verify_authorized

  def index
    authorize NodeLink
    redirect_to browse_path
  end

  def show
    @node_link = authorize NodeLink.find(params[:id])
    redirect_to @node_link.node
  end
end
