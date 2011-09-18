#--
# $Id: 002_add_adhocracy_tables.rb 2454 2006-03-29 04:19:02Z keegan $
# Copyright 2004-2006 Keegan Quinn
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#++

class AddAdhocracyTables < ActiveRecord::Migration
  def self.up
    up_Role
    up_UserComment
    up_UserLink
    up_UserLog
    up_Zone
    up_ZoneMaintainer
    up_Service
    up_Status
    up_Node
    up_NodeComment
    up_NodeLink
    up_NodeLog
    up_NodeMaintainer
    up_HostType
    up_Host
    up_HostLog
    up_HostProperty
    up_HostService
    up_InterfaceType
    up_Interface
    up_InterfacePoint
    up_WirelessInterface
  end

  def self.down
    down_WirelessInterface
    down_InterfacePoint
    down_Interface
    down_InterfaceType
    down_HostService
    down_HostProperty
    down_HostLog
    down_Host
    down_HostType
    down_NodeMaintainer
    down_NodeLog
    down_NodeLink
    down_NodeComment
    down_Node
    down_Status
    down_Service
    down_ZoneMaintainer
    down_Zone
    down_UserLog
    down_UserLink
    down_UserComment
    down_Role
  end

  def self.up_Role
    create_table(:roles) do |t|
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :code,       :string, :limit => 32, :null => false
      t.column :name,       :text
    end

    add_index(:roles, :code, :unique => true)

    create_table(:roles_users) do |t|
      t.column :role_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end

    add_index(:roles_users, [ :role_id, :user_id ], :unique => true)
  end

  def self.down_Role
    remove_index(:roles_users, :role_id)

    drop_table(:roles_users)

    remove_index(:roles, :code)

    drop_table(:roles)
  end

  def self.up_UserComment
    create_table(:user_comments) do |t|
      t.column :created_at,         :datetime
      t.column :updated_at,         :datetime
      t.column :user_id,            :integer, :null => false
      t.column :commenting_user_id, :integer, :null => false
      t.column :subject,            :string,  :limit => 255, :null => false
      t.column :body,               :text,    :null => false
      t.column :rating,             :integer, :default => 0, :null => false
      t.column :active,             :boolean, :default => true, :null => false
    end

    add_index(:user_comments, [ :user_id, :commenting_user_id ])
  end

  def self.down_UserComment
    remove_index(:user_comments, :user_id)

    drop_table(:user_comments)
  end

  def self.up_UserLink
    create_table(:user_links) do |t|
      t.column :created_at,  :datetime
      t.column :updated_at,  :datetime
      t.column :user_id,     :integer, :null => false
      t.column :name,        :string,  :limit => 64, :null => false
      t.column :application, :string,  :limit => 16, :null => false
      t.column :data,        :string,  :limit => 255, :null => false
      t.column :active,      :boolean, :default => true, :null => false
    end

    add_index(:user_links, [ :user_id, :name ], :unique => true)
  end

  def self.down_UserLink
    remove_index(:user_links, :user_id)

    drop_table(:user_links)
  end

  def self.up_UserLog
    create_table(:user_logs) do |t|
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :user_id,    :integer, :null => false
      t.column :subject,    :string,  :limit => 255, :null => false
      t.column :body,       :text,    :null => false
      t.column :active,     :boolean, :default => true, :null => false
    end

    add_index(:user_logs, [ :user_id, :subject ], :unique => true)
  end

  def self.down_UserLog
    remove_index(:user_logs, :user_id)

    drop_table(:user_logs)
  end

  def self.up_Zone
    create_table(:zones) do |t|
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :code,       :string,  :limit => 64, :null => false
      t.column :name,       :string,  :limit => 128, :null => false
      t.column :locality,   :text
      t.column :expose,     :boolean, :default => true, :null => false
    end

    add_index(:zones, :code, :unique => true)
  end

  def self.down_Zone
    remove_index(:zones, :code)

    drop_table(:zones)
  end

  def self.up_ZoneMaintainer
    create_table(:zone_maintainers) do |t|
      t.column :created_at,  :datetime
      t.column :updated_at,  :datetime
      t.column :zone_id,     :integer, :null => false
      t.column :user_id,     :integer, :null => false
      t.column :description, :text
    end

    add_index(:zone_maintainers, [ :zone_id, :user_id ], :unique => true)
  end

  def self.down_ZoneMaintainer
    remove_index(:zone_maintainers, :zone_id)

    drop_table(:zone_maintainers)
  end

  def self.up_Service
    create_table(:services) do |t|
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :code,       :string,  :limit => 64, :null => false
      t.column :name,       :string,  :limit => 128, :null => false
      t.column :protocol,   :string,  :limit => 8
      t.column :port,       :integer
      t.column :expose,     :boolean, :default => true, :null => false
    end

    add_index(:services, :code, :unique => true)
  end

  def self.down_Service
    remove_index(:services, :code)

    drop_table(:services)
  end

  def self.up_Status
    create_table(:statuses) do |t|
      t.column :created_at,    :datetime
      t.column :updated_at,    :datetime
      t.column :code,          :string,  :limit => 64, :null => false
      t.column :name,          :string,  :limit => 64, :null => false
      t.column :description,   :text
      t.column :display_red,   :integer
      t.column :display_green, :integer
      t.column :display_blue,  :integer
      t.column :expose,        :boolean, :default => true, :null => false
    end

    add_index(:statuses, :code, :unique => true)
  end

  def self.down_Status
    remove_index(:statuses, :code)

    drop_table(:statuses)
  end

  def self.up_Node
    create_table(:nodes) do |t|
      t.column :created_at,    :datetime
      t.column :updated_at,    :datetime
      t.column :zone_id,       :integer, :null => false
      t.column :status_id,     :integer, :null => false
      t.column :user_id,       :integer, :null => false
      t.column :code,          :string,  :limit => 64, :null => false
      t.column :name,          :string,  :limit => 128, :null => false
      t.column :description,   :text
      t.column :legacy_number, :string,  :limit => 16
      t.column :address,       :text
      t.column :city,          :string,  :limit => 128
      t.column :state,         :string,  :limit => 2
      t.column :postalcode,    :string,  :limit => 16
      t.column :country,       :string,  :limit => 2
      t.column :public,        :boolean, :default => false, :null => false
      t.column :mailing_ok,    :boolean, :default => false, :null => false
      t.column :expose,        :boolean, :default => true, :null => false
    end

    add_index(:nodes, :code, :unique => true)
  end

  def self.down_Node
    remove_index(:nodes, :code)

    drop_table(:nodes)
  end

  def self.up_NodeComment
    create_table(:node_comments) do |t|
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :node_id,    :integer, :null => false
      t.column :user_id,    :integer, :null => false
      t.column :subject,    :string,  :limit => 255, :null => false
      t.column :body,       :text,    :null => false
      t.column :rating,     :integer, :default => 0, :null => false
      t.column :active,     :boolean, :default => true, :null => false
    end

    add_index(:node_comments, [ :node_id, :user_id ])
  end

  def self.down_NodeComment
    remove_index(:node_comments, :node_id)

    drop_table(:node_comments)
  end

  def self.up_NodeLink
    create_table(:node_links) do |t|
      t.column :created_at,  :datetime
      t.column :updated_at,  :datetime
      t.column :node_id,     :integer, :null => false
      t.column :name,        :string,  :limit => 64, :null => false
      t.column :application, :string,  :limit => 16, :null => false
      t.column :data,        :string,  :limit => 255, :null => false
      t.column :active,      :boolean, :default => true, :null => false
    end

    add_index(:node_links, [ :node_id, :name ], :unique => true)
  end

  def self.down_NodeLink
    remove_index(:node_links, :node_id)

    drop_table(:node_links)
  end

  def self.up_NodeLog
    create_table(:node_logs) do |t|
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :node_id,    :integer, :null => false
      t.column :user_id,    :integer, :null => false
      t.column :subject,    :string,  :limit => 255, :null => false
      t.column :body,       :text,    :null => false
      t.column :active,     :boolean, :default => true, :null => false
    end

    add_index(:node_logs, [ :node_id, :user_id ])
  end

  def self.down_NodeLog
    remove_index(:node_logs, :node_id)

    drop_table(:node_logs)
  end

  def self.up_NodeMaintainer
    create_table(:node_maintainers) do |t|
      t.column :created_at,  :datetime
      t.column :updated_at,  :datetime
      t.column :node_id,     :integer, :null => false
      t.column :user_id,     :integer, :null => false
      t.column :description, :text
    end

    add_index(:node_maintainers, [ :node_id, :user_id ], :unique => true)
  end

  def self.down_NodeMaintainer
    remove_index(:node_maintainers, :node_id)

    drop_table(:node_maintainers)
  end

  def self.up_HostType
    create_table(:host_types) do |t|
      t.column :created_at,  :datetime
      t.column :updated_at,  :datetime
      t.column :code,        :string,  :limit => 64, :null => false
      t.column :name,        :string,  :limit => 255, :null => false
      t.column :description, :text
      t.column :expose,      :boolean, :default => true, :null => false
    end

    add_index(:host_types, :code, :unique => true)
  end

  def self.down_HostType
    remove_index(:host_types, :code)

    drop_table(:host_types)
  end

  def self.up_Host
    create_table(:hosts) do |t|
      t.column :created_at,         :datetime
      t.column :updated_at,         :datetime
      t.column :node_id,            :integer, :null => false
      t.column :host_type_id,       :integer, :null => false
      t.column :status_id,          :integer, :null => false
      t.column :name,               :string,  :limit => 64, :null => false
      t.column :top_level_hostname, :boolean, :default => false
      t.column :description,        :text
      t.column :active,             :boolean, :default => true, :null => false
    end

    add_index(:hosts, :name, :unique => true)
  end

  def self.down_Host
    remove_index(:hosts, :name)

    drop_table(:hosts)
  end

  def self.up_HostLog
    create_table(:host_logs) do |t|
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :host_id,    :integer, :null => false
      t.column :user_id,    :integer, :null => false
      t.column :subject,    :string,  :limit => 255, :null => false
      t.column :body,       :text,    :null => false
      t.column :active,     :boolean, :default => true, :null => false
    end

    add_index(:host_logs, [ :host_id, :user_id ])
  end

  def self.down_HostLog
    remove_index(:host_logs, :host_id)

    drop_table(:host_logs)
  end

  def self.up_HostProperty
    create_table(:host_properties) do |t|
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :host_id,    :integer, :null => false
      t.column :key,        :string,  :limit => 64, :null => false
      t.column :value,      :text,    :null => false
    end

    add_index(:host_properties, [ :host_id, :key ], :unique => true)
  end

  def self.down_HostProperty
    remove_index(:host_properties, :host_id)

    drop_table(:host_properties)
  end

  def self.up_HostService
    create_table(:host_services) do |t|
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :host_id,    :integer, :null => false
      t.column :service_id, :integer, :null => false
    end

    add_index(:host_services, [ :host_id, :service_id ], :unique => true)
  end

  def self.down_HostService
    remove_index(:host_services, :host_id)

    drop_table(:host_services)
  end

  def self.up_InterfaceType
    create_table(:interface_types) do |t|
      t.column :created_at,  :datetime
      t.column :updated_at,  :datetime
      t.column :code,        :string,  :limit => 64, :null => false
      t.column :name,        :string,  :limit => 255, :null => false
      t.column :description, :text
      t.column :wireless,    :boolean, :default => false, :null => false
      t.column :expose,      :boolean, :default => true, :null => false
    end

    add_index(:interface_types, :code, :unique => true)
  end

  def self.down_InterfaceType
    remove_index(:interface_types, :code)

    drop_table(:interface_types)
  end

  def self.up_Interface
    create_table(:interfaces) do |t|
      t.column :created_at,        :datetime
      t.column :updated_at,        :datetime
      t.column :host_id,           :integer, :null => false
      t.column :interface_type_id, :integer, :null => false
      t.column :status_id,         :integer, :null => false
      t.column :code,              :string,  :limit => 64, :null => false
      t.column :address,           :string,  :limit => 20, :null => false
      t.column :mac,               :string,  :limit => 20
      t.column :name,              :string,  :limit => 128
      t.column :description,       :text
      t.column :latency,           :float
      t.column :bandwidth,         :float
      t.column :active,            :boolean, :default => true, :null => false
    end

    add_index(:interfaces, [ :host_id, :code ], :unique => true)
  end

  def self.down_Interface
    remove_index(:interfaces, :host_id)

    drop_table(:interfaces)
  end

  def self.up_InterfacePoint
    create_table(:interface_points) do |t|
      t.column :created_at,   :datetime
      t.column :updated_at,   :datetime
      t.column :interface_id, :integer, :null => false
      t.column :latitude,     :float,   :null => false
      t.column :longitude,    :float,   :null => false
      t.column :height,       :float,   :null => false
      t.column :error,        :float,   :null => false
      t.column :description,  :text,    :null => false
    end

    add_index(:interface_points, [ :interface_id, :description ],
              :unique => true)
  end

  def self.down_InterfacePoint
    remove_index(:interface_points, :interface_id)

    drop_table(:interface_points)
  end

  def self.up_WirelessInterface
    create_table(:wireless_interfaces) do |t|
      t.column :created_at,   :datetime
      t.column :updated_at,   :datetime
      t.column :interface_id, :integer, :null => false
      t.column :mode,         :integer
      t.column :essid,        :string,  :limit => 32
      t.column :channel,      :integer
      t.column :eirp,         :float
      t.column :beamwidth_v,  :float
      t.column :beamwidth_h,  :float
      t.column :azimuth,      :float
      t.column :elevation,    :float
      t.column :polarity,     :string, :limit => 16
      t.column :error,        :float
    end

    add_index(:wireless_interfaces, :interface_id)
  end

  def self.down_WirelessInterface
    remove_index(:wireless_interfaces, :interface_id)

    drop_table(:wireless_interfaces)
  end
end
