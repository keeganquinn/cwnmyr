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

  def update?
    create?
  end

  def destroy?
    create?
  end

  def build?
    update? && @record.can_build?
  end

  def build_config?
    show?
  end

  def graph?
    show?
  end
end
