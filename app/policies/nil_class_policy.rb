# frozen_string_literal: true

# Pundit access control policy for NilClass.
class NilClassPolicy < ApplicationPolicy
  def show?
    true
  end
end
