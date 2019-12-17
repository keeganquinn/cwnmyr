# frozen_string_literal: true

# Pundit access control policy for ContactsController.
class ContactPolicy < ApplicationPolicy
  # Check policy for show action.
  def show?
    return true unless @record.hidden

    create?
  end

  # Check policy for create action.
  def create?
    return false unless @user

    @user.try(:admin?) || @record.user == @user ||
      @record.group&.users&.include?(@user)
  end

  # Check policy for update action.
  def update?
    create?
  end

  # Check policy for destroy action.
  def destroy?
    create?
  end

  # Permitted attributes for updates.
  def permitted_attributes
    %i[user_id code name hidden email phone notes group_id]
  end
end
