# frozen_string_literal: true

# Pundit access control policy for EventsController.
class EventPolicy < ApplicationPolicy
  def index?
    true
  end
end
