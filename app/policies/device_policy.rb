# frozen_string_literal: true

# Pundit access control policy for DevicesController.
class DevicePolicy < ApplicationPolicy
  def conf?
    show?
  end

  def create?
    return false unless @record.node

    NodePolicy.new(@user, @record.node).create?
  end

  def build?
    create?
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
