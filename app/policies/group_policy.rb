# frozen_string_literal: true

# Pundit access control policy for GroupsController.
class GroupPolicy < ApplicationPolicy
  def update?
    @user.try(:admin?)
  end
end
