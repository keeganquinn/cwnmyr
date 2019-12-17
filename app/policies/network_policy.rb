# frozen_string_literal: true

# Pundit access control policy for NetworksController.
class NetworkPolicy < ApplicationPolicy
  # Check policy for index action.
  def index?
    true
  end
end
