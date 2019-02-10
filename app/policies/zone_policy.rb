# frozen_string_literal: true

# Pundit access control policy for ZonesController.
class ZonePolicy < ApplicationPolicy
  def index?
    true
  end

  def conf?
    show?
  end
end
