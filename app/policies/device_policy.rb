# frozen_string_literal: true

# Pundit access control policy for DevicesController.
class DevicePolicy < ApplicationPolicy
  def create?
    return false unless @user

    @user.try(:admin?) || @record.node.user == @user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def graph?
    show?
  end
end
