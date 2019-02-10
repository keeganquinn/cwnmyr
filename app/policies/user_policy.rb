# frozen_string_literal: true

# Pundit access control policy for UsersController.
class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def update?
    @record == @user
  end
end
