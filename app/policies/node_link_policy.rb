# frozen_string_literal: true

# Pundit access control policy for NodeLinksController.
class NodeLinkPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    return false unless @record.node

    NodePolicy.new(@user, @record.node).create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
