# frozen_string_literal: true

# Pundit access control policy for DeviceTypesController.
class DeviceTypePolicy < ApplicationPolicy
  # Check policy for index action.
  def index?
    true
  end
end
