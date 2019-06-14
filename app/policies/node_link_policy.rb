# frozen_string_literal: true

# Pundit access control policy for NodeLinksController.
class NodeLinkPolicy < ApplicationPolicy
  def create?
    NodePolicy.new(@user, @record.node).create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
