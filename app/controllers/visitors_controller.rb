# frozen_string_literal: true

# Visitors controller. This controller serves the default root page.
class VisitorsController < ApplicationController
  layout 'big', only: [:index]

  def index; end

  def search
    @results = Searchkick.search params[:query],
                                 index_name: [Node], match: :word_start
  end
end
