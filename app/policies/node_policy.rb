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

  def markers?
    true
  end

  def new?
    @current_user
  end

  def create?
    @current_user
  end

  def edit?
    return false if not @current_user
    @current_user.try(:admin?) or @model.user == @current_user
  end

  def update?
    return false if not @current_user
    @current_user.try(:admin?) or @model.user == @current_user
  end

  def destroy?
    return false if not @current_user
    @current_user.try(:admin?) or @model.user == @current_user
  end
end
