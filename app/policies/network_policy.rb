# frozen_string_literal: true

# Pundit access control policy for NetworksController.
class NetworkPolicy < ApplicationPolicy
  def index?
    true
  end
end
