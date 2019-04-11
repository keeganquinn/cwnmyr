# frozen_string_literal: true

# Visitors controller. This controller serves the default root page.
class VisitorsController < ApplicationController
  def index; end

  def search
    return redirect_to root_path if params[:query].blank?

    @results = Searchkick.search params[:query], index_name: [Node]
  end
end
