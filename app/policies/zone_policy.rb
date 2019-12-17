# frozen_string_literal: true

# Pundit access control policy for ZonesController.
class ZonePolicy < ApplicationPolicy
  # Check policy for index action.
  def index?
    true
  end

  # Check policy for conf action.
  def conf?
    show?
  end
end
