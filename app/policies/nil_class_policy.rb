# frozen_string_literal: true

# Pundit access control policy for NilClass.
class NilClassPolicy < ApplicationPolicy
  # Check policy for show action.
  def show?
    true
  end
end
