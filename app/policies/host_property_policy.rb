# frozen_string_literal: true

# Pundit access control policy for HostPropertiesController.
class HostPropertyPolicy < ApplicationPolicy
  def create?
    return false unless @user

    @user.try(:admin?) || @record.host.node.user == @user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
