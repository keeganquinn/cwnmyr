# frozen_string_literal: true

# Pundit access control policy for NodesController.
class NodePolicy < ApplicationPolicy
  def create?
    return false unless @user

    @user.try(:admin?) || @record.user == @user ||
      @record.group&.users&.include?(@user)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def graph?
    show?
  end
end
