# frozen_string_literal: true

# Pundit access control policy for GroupsController.
class GroupPolicy < ApplicationPolicy
  # Check policy for update action.
  def update?
    @user.try(:admin?)
  end
end
