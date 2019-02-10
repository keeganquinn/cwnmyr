# frozen_string_literal: true

# Pundit access control policy for UserLinksController.
class UserLinkPolicy < ApplicationPolicy
  def create?
    return false unless @user

    @user.try(:admin?) || @record.user == @user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
