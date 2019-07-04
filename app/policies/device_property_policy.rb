# frozen_string_literal: true

# Pundit access control policy for DevicePropertiesController.
class DevicePropertyPolicy < ApplicationPolicy
  def index?
    true
  end

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
