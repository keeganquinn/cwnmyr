#--
# $Id: 007_improved_host_types.rb 2641 2006-05-20 06:39:19Z keegan $
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

class ImprovedHostTypes < ActiveRecord::Migration
  def self.up
    add_column(:host_types, :overview, :text)
    add_column(:host_types, :instructions, :text)

    create_table(:host_type_comments) do |t|
      t.column :created_at,   :datetime
      t.column :updated_at,   :datetime
      t.column :host_type_id, :integer, :null => false
      t.column :user_id,      :integer, :null => false
      t.column :subject,      :string,  :limit => 255, :null => false
      t.column :body,         :text
      t.column :rating,       :integer, :default => 0, :null => false
      t.column :active,       :boolean, :default => true, :null => false
    end

    add_index(:host_type_comments, [ :host_type_id, :user_id ])
  end

  def self.down
    remove_index(:host_type_comments, :host_type_id)

    drop_table(:host_type_comments)

    remove_column(:host_types, :instructions)
    remove_column(:host_types, :overview)
  end
end
