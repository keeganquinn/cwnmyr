# frozen_string_literal: true

# Handle errors gracefully.
class ErrorsController < ApplicationController
  def not_found
    respond_to do |format|
      format.html { render status: 404 }
      format.json { render json: { error: 'Resource not found' }, status: 404 }
      format.any  { head :not_found }
    end
  end

  def unacceptable
    respond_to do |format|
      format.html { render status: 422 }
      format.json { render json: { error: 'Input unacceptable' }, status: 422 }
      format.any  { head :unprocessable_entity }
    end
  end

  def internal_error
    respond_to do |format|
      format.html { render status: 500 }
      format.json { render json: { error: 'Internal error' }, status: 500 }
      format.any  { head :internal_server_error }
    end
  end
end
