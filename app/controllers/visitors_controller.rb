# frozen_string_literal: true

# Visitors controller. This controller serves the default root page.
class VisitorsController < ApplicationController
  layout 'big', only: [:index]

  def index
    @zone = Zone.default
    serve_image if params[:format] == 'png'
  end

  def search
    @results = Searchkick.search params[:query],
                                 index_name: [Node], match: :word_start
  end

  private

  def zone
    Zone.default
  end

  def blob
    if params[:resize]
      zone.nav_logo.variant(resize: params[:resize], quality: '00').processed
    else
      zone.nav_logo.blob
    end
  end

  def serve_image
    return head(:not_found) unless zone.nav_logo.attached?

    expires_in 1.year, public: true
    send_data blob.service.download(blob.key),
              type: zone.nav_logo.blob.content_type, disposition: 'inline'
  end
end
