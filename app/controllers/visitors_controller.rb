# frozen_string_literal: true

# Visitors controller. This controller serves the default root page and all
# of the theme-related assets from the default Zone.
class VisitorsController < ApplicationController
  layout 'big', only: [:index]
  before_action :set_zone

  def index
    serve_image :nav_logo if params[:format] == 'png'
  end

  def chromeicon_192
    serve_image :chromeicon_192
  end

  def chromeicon_512
    serve_image :chromeicon_512
  end

  def touchicon_180
    serve_image :touchicon_180
  end

  def favicon_png16
    serve_image :favicon_png16
  end

  def favicon_png32
    serve_image :favicon_png32
  end

  def favicon_ico
    serve_image :favicon_ico
  end

  def mstile_150
    serve_image :mstile_150
  end

  def maskicon_svg
    serve_image :maskicon_svg
  end

  private

  def set_zone
    @zone = Zone.default
  end

  def blob(attr)
    if params[:resize]
      attr.variant(resize: params[:resize], quality: '00').processed
    else
      attr.blob
    end
  end

  def serve_image(key)
    attr = Zone.default.send(key)
    return head(:not_found) unless attr&.attached?

    expires_in 1.year, public: true
    send_data blob(attr).service.download(blob(attr).key),
              type: attr.blob.content_type, disposition: 'inline'
  end
end
