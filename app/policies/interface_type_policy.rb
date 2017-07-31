# Pundit access control policy for InterfaceTypesController.
class InterfaceTypePolicy < ApplicationPolicy
  def index?
    true
  end
end
