# Pundit access control policy for HostTypesController.
class HostTypePolicy < ApplicationPolicy
  def index?
    true
  end
end
