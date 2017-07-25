# Pundit access control policy for ZonesController.
class ZonePolicy
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

  def conf?
    true
  end
end
