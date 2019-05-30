# frozen_string_literal: true

# Pundit access control policy for InterfacesController.
class InterfacePolicy < ApplicationPolicy
  def create?
    return false unless @user

    @user.try(:admin?) || @record.device.node.user == @user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
