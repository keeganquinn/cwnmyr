# frozen_string_literal: true

# This concern constructs error responses when JSON requests fail.
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  # Render an appropriate response for an record invalid exception.
  def record_invalid(error)
    raise unless request.format.json? || request.format.xml?

    respond_to do |format|
      format.json do
        render json: { error: error.message }, status: :unprocessable_entity
      end
      format.xml do
        render xml: { error: error.message }, status: :unprocessable_entity
      end
    end
  end

  # Render an appropriate response for a record not found exception.
  def record_not_found(error)
    raise unless request.format.json? || request.format.xml?

    respond_to do |format|
      format.json do
        render json: { error: error.message }, status: :not_found
      end
      format.xml do
        render xml: { error: error.message }, status: :not_found
      end
    end
  end
end
