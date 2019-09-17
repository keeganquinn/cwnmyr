# frozen_string_literal: true

# Pundit access control policy for DevicesController.
class DevicePolicy < ApplicationPolicy
  def conf?
    show?
  end

  def create?
    return false unless @record.node

    NodePolicy.new(@user, @record.node).create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def build?
    update? && @record.can_build?
  end

  def build_config?
    show?
  end

  def graph?
    show?
  end

  def permitted_attributes
    [:node_id, :name, :device_type_id, :body,
     interfaces_attributes: %i[id code name network_id address_ipv6 address_ipv4
                               address_mac _destroy],
     device_properties_attributes: %i[id device_property_type_id
                                      device_property_option_id value _destroy]]
  end
end
