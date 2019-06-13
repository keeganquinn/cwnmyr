# frozen_string_literal: true

# Pundit access control policy for ContactsController.
class ContactPolicy < ApplicationPolicy
  def show?
    return true unless @record.hidden
    return false unless @user

    @record.user == @user || @user.try(:admin?)
  end

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
