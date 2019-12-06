# frozen_string_literal: true

# This controller facilitates interaction with Events.
class EventsController < ApplicationController
  after_action :verify_authorized

  def index
    @events = authorize Event.all
  end

  def show
    @event = authorize Event.find(params[:id])
    serve_image if params[:format] == 'jpg'
  end

  private

  def blob
    @event.image.blob
  end

  def serve_image
    return head(:not_found) unless @event.image.attached?

    expires_in 1.year, public: true
    send_data blob.service.download(blob.key),
              type: blob.content_type, disposition: 'inline'
  end
end
