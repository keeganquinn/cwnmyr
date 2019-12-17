# frozen_string_literal: true

# Pundit access control policy for EventsController.
class EventPolicy < ApplicationPolicy
  # Check policy for index action.
  def index?
    true
  end
end
