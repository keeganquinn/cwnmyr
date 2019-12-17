# frozen_string_literal: true

# This class is parent to all policies in the application.
class ApplicationPolicy
  attr_reader :user, :record

  # Initialize a new Pundit policy.
  def initialize(user, record)
    @user = user
    @record = record
  end

  # Check default policy for index action.
  def index?
    false
  end

  # Check default policy for show action.
  def show?
    scope.where(id: record.id).exists?
  end

  # Check default policy for create action.
  def create?
    false
  end

  # Check default policy for new action.
  def new?
    create?
  end

  # Check default policy for update action.
  def update?
    false
  end

  # Check default policy for edit action.
  def edit?
    update?
  end

  # Check default policy for destroy action.
  def destroy?
    false
  end

  # Check default policy scope.
  def scope
    Pundit.policy_scope!(user, record.class)
  end

  # Helper class for resolving record values.
  class Scope
    attr_reader :user, :scope

    # Initialize a new policy scope.
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # The current policy scope.
    def resolve
      scope
    end
  end
end
