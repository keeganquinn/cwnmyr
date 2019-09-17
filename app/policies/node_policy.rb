# frozen_string_literal: true

# Pundit access control policy for NodesController.
class NodePolicy < ApplicationPolicy
  def create?
    return false unless @user

    @user.try(:admin?) || @record.user == @user ||
      @record.group&.users&.include?(@user)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def graph?
    show?
  end

  def permitted_attributes
    [:user_id, :code, :name, :status_id, :group_id, :contact_id, :body,
     :address, :hours, :notes, :live_date, :website, :rss, :twitter, :wiki,
     :logo,
     contact_attributes: %i[id name hidden email phone notes user_id _destroy]]
  end
end
