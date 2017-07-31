# Pundit access control policy for InterfacesController.
class InterfacePropertyPolicy < ApplicationPolicy
  def create?
    return false unless @user
    @user.try(:admin?) || @record.interface.host.node.user == @user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
