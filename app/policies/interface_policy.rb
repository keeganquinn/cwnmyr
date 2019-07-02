# frozen_string_literal: true

# Pundit access control policy for InterfacesController.
class InterfacePolicy < ApplicationPolicy
  def create?
    return false unless @record.device

    DevicePolicy.new(@user, @record.device).create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
