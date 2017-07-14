# Pundit access control policy for NodesController.
class NodePolicy
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

  def new?
    @current_user
  end

  def create?
    @current_user
  end

  def edit?
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

  def graph?
    true
  end
end
