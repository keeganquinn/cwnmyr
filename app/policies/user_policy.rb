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

  # Check policy for confirm action.
  def confirm?
    update?
  end

  # Check policy for deny action.
  def deny?
    update?
  end

  # Check policy for revoke action.
  def revoke?
    update?
  end

  # Permitted attributes for updates.
  def permitted_attributes
    %i[name body authorized_keys]
  end
end
