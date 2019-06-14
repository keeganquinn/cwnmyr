# frozen_string_literal: true

# Pundit access control policy for DevicePropertiesController.
class DevicePropertyPolicy < ApplicationPolicy
  def create?
    DevicePolicy.new(@user, @record.device).create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
