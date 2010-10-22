#--
# $Id: interface_property_controller.rb 2753 2006-06-16 08:57:06Z keegan $
# Copyright 2006 Keegan Quinn
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

class InterfacePropertyController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @interface_property = InterfaceProperty.find(params[:id])

    @page_heading = 'Interface property: ' + @interface_property.type.code
  end

  def new
    @interface_property = InterfaceProperty.new(params[:interface_property])
    @interface_property.interface = Interface.find params[:interface_id]

    @page_heading = 'New interface property'

    return unless request.post?

    if @interface_property.save
      flash[:notice] = 'Interface property was successfully created.'
      redirect_to(:controller => 'interface',
                  :action => 'show',
                  :node_code => @interface_property.interface.host.node.code,
                  :hostname => @interface_property.interface.host.name,
                  :code => @interface_property.interface.code)
    end
  end

  def edit
    @interface_property = InterfaceProperty.find(params[:id])

    @page_heading = 'Interface property: ' + @interface_property.type.code

    return unless request.post?

    if @interface_property.update_attributes(params[:interface_property])
      flash[:notice] = 'Interface property was successfully updated.'
      redirect_to :action => 'show', :id => @interface_property.id
    end
  end

  def destroy
    interface_property = InterfaceProperty.find(params[:id])
    interface = interface_property.interface
    interface_property.destroy
    flash[:notice] = 'Interface property was successfully destroyed.'
    redirect_to(:controller => 'interface',
                :action => 'show',
                :node_code => interface.host.node.code,
                :hostname => interface.host.name,
                :code => interface.code)
  end
end
