# frozen_string_literal: true

# Handle errors gracefully.
class ErrorsController < ApplicationController
  # Render an appropriate response for a 404 error.
  def not_found
    respond_to do |format|
      format.html { render status: 404 }
      format.json { render json: { error: 'Resource not found' }, status: 404 }
      format.any  { head :not_found }
    end
  end

  # Render an appropriate response for a 422 error.
  def unacceptable
    respond_to do |format|
      format.html { render status: 422 }
      format.json { render json: { error: 'Input unacceptable' }, status: 422 }
      format.any  { head :unprocessable_entity }
    end
  end

  # Render an appropriate response for a 500 error.
  def internal_error
    respond_to do |format|
      format.html { render status: 500 }
      format.json { render json: { error: 'Internal error' }, status: 500 }
      format.any  { head :internal_server_error }
    end
  end
end
