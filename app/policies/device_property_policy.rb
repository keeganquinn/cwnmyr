# frozen_string_literal: true

# Pundit access control policy for DevicePropertiesController.
class DevicePropertyPolicy < ApplicationPolicy
  # Check policy for index action.
  def index?
    true
  end

  # Check policy for create action.
  def create?
    return false unless @record.device

    DevicePolicy.new(@user, @record.device).create?
  end

  # Check policy for update action.
  def update?
    create?
  end

  # Check policy for destroy action.
  def destroy?
    create?
  end
end
