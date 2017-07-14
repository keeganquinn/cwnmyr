# Pundit access control policy for UserLinksController.
class UserLinkPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    return false unless @current_user
    @current_user.try(:admin?) || @model.user == @current_user
  end

  def update?
    return false unless @current_user
    @current_user.try(:admin?) || @model.user == @current_user
  end

  def destroy?
    return false unless @current_user
    @current_user.try(:admin?) || @model.user == @current_user
  end
end