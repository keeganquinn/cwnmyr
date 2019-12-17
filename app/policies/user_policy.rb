# frozen_string_literal: true

# Pundit access control policy for UsersController.
class UserPolicy < ApplicationPolicy
  # Check policy for index action.
  def index?
    true
  end

  # Check policy for update action.
  def update?
    @record == @user
  end

  # Permitted attributes for updates.
  def permitted_attributes
    %i[name body]
  end
end
