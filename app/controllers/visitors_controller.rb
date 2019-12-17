# frozen_string_literal: true

# Visitors controller. This controller serves the default root page and all
# of the theme-related assets from the default Zone.
class VisitorsController < ApplicationController
  layout 'big', only: [:index]
  before_action :set_zone

  # Index action.
  def index
    serve_image :nav_logo if params[:format] == 'png'
  end

  # Serve the current Android/Chrome 192x192 icon.
  def chromeicon_192
    serve_image :chromeicon_192
  end

  # Serve the current Android/Chrome 512x512 icon.
  def chromeicon_512
    serve_image :chromeicon_512
  end

  # Serve the current Apple touch icon.
  def touchicon_180
    serve_image :touchicon_180
  end

  # Serve the current 16x16 PNG icon.
  def favicon_png16
    serve_image :favicon_png16
  end

  # Serve the current 32x32 PNG icon.
  def favicon_png32
    serve_image :favicon_png32
  end

  # Serve the current favorites icon.
  def favicon_ico
    serve_image :favicon_ico
  end

  # Serve the current Microsoft 150x150 tile icon.
  def mstile_150
    serve_image :mstile_150
  end

  # Serve the current mask SVG.
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
