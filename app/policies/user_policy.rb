# Pundit access control policy for UsersController.
class UserPolicy < ApplicationPolicy
  def index?
    true
  end
end
