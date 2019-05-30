# frozen_string_literal: true

# Pundit access control policy for DeviceTypesController.
class DeviceTypePolicy < ApplicationPolicy
  def index?
    true
  end
end
