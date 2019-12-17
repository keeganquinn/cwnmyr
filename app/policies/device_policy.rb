# frozen_string_literal: true

# Pundit access control policy for DevicesController.
class DevicePolicy < ApplicationPolicy
  # Check policy for conf action.
  def conf?
    show?
  end

  # Check policy for create action.
  def create?
    return false unless @record.node

    NodePolicy.new(@user, @record.node).create?
  end

  # Check policy for update action.
  def update?
    create?
  end

  # Check policy for destroy action.
  def destroy?
    create?
  end

  # Check policy for build action.
  def build?
    update? && @record.can_build?
  end

  # Check policy for build_config action.
  def build_config?
    show?
  end

  # Check policy for graph action.
  def graph?
    show?
  end

  # Permitted attributes for updates.
  def permitted_attributes
    [:node_id, :name, :device_type_id, :body,
     interfaces_attributes: %i[id code name network_id address_ipv6 address_ipv4
                               address_mac _destroy],
     device_properties_attributes: %i[id device_property_type_id
                                      device_property_option_id value _destroy]]
  end
end
