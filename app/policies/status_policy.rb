# frozen_string_literal: true

# Pundit access control policy for StatusesController.
class StatusPolicy < ApplicationPolicy
  # Check policy for index action.
  def index?
    true
  end
end
