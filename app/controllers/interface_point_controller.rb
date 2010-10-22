#--
# $Id: interface_point_controller.rb 2737 2006-06-10 06:22:30Z keegan $
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

class InterfacePointController < ApplicationController
  before_filter :login_required

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @interface_point = InterfacePoint.find(params[:id])

    @page_heading = 'Interface: ' + @interface_point.interface.code +
      ' GPS data point'
  end

  def new
    @interface_point = InterfacePoint.new(params[:interface_point])
    @interface_point.interface = Interface.find params[:interface_id]

    @page_heading = 'New GPS data point'

    return unless request.post?

    if @interface_point.save
      flash[:notice] = 'GPS data point was successfully created.'
      redirect_to(:controller => 'interface',
                  :action => 'show',
                  :node_code => @interface_point.interface.host.node.code,
                  :hostname => @interface_point.interface.host.name,
                  :code => @interface_point.interface.code)
    end
  end

  def edit
    @interface_point = InterfacePoint.find(params[:id])

    @page_heading = 'Interface: ' + @interface_point.interface.code +
      ' GPS data point'

    return unless request.post?

    if @interface_point.update_attributes(params[:interface_point])
      flash[:notice] = 'GPS data point was successfully updated.'
      redirect_to :action => 'show', :id => @interface_point.id
    end
  end

  def destroy
    interface_point = InterfacePoint.find(params[:id])
    interface = interface_point.interface
    interface_point.destroy
    flash[:notice] = 'GPS data point was successfully destroyed.'
    redirect_to(:controller => 'interface',
                :action => 'show',
                :node_code => interface.host.node.code,
                :hostname => interface.host.name,
                :code => interface.code)
  end
end
