# frozen_string_literal: true

# Pundit access control policy for NodesController.
class NodePolicy < ApplicationPolicy
  # Check policy for create action.
  def create?
    return false unless @user

    @user.try(:admin?) || @record.user == @user ||
      @record.group&.users&.include?(@user)
  end

  # Check policy for update action.
  def update?
    create?
  end

  # Check policy for destroy action.
  def destroy?
    create?
  end

  # Check policy for graph action.
  def graph?
    show?
  end

  # Permitted attributes for updates.
  def permitted_attributes
    [:user_id, :code, :name, :status_id, :group_id, :contact_id, :body,
     :address, :hours, :notes, :live_date, :website, :rss, :twitter, :wiki,
     :logo,
     contact_attributes: %i[id name hidden email phone notes user_id _destroy]]
  end
end
