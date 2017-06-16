class NodePolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def show?
    true
  end

  def markers?
    true
  end
end
