# frozen_string_literal: true

# Pundit access control policy for NodeLinksController.
class NodeLinkPolicy < ApplicationPolicy
  def create?
    return false unless @user

    @user.try(:admin?) || @record.node.user == @user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
