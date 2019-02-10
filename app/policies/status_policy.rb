# frozen_string_literal: true

# Pundit access control policy for StatusesController.
class StatusPolicy < ApplicationPolicy
  def index?
    true
  end
end
