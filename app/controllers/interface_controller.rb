#--
# $Id: interface_controller.rb 2746 2006-06-11 01:36:32Z keegan $
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

class InterfaceController < ApplicationController
  before_filter :login_required, :except => [ :map, :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @interface = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname]).interfaces.find_by_code(params[:code])

    @page_heading = 'Interface: ' + @interface.code
  end

  def map
    @interface = Interface.find(params[:id])

    @page_heading = 'Interface map: ' + @interface.code

    if point = @interface.average_point
      marker = GMarker.new([point[:latitude], point[:longitude]],
                           :title => @interface.code,
                           :info_window => @interface.code)

      @map = GMap.new('interface_map')
      @map.overlay_init Clusterer.new([marker])
      @map.center_zoom_init marker.point, 18
    end
  end

  def new
    @interface = Interface.new params[:interface]
    @interface.host = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname])

    @page_heading = 'New interface'

    return unless request.post?

    if @interface.save
      flash[:notice] = 'Interface was successfully created.'

      redirect_to(:controller => 'host',
                  :action => 'show',
                  :node_code => @interface.host.node.code,
                  :hostname => @interface.host.name)
    end
  end

  def edit
    @interface = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname]).interfaces.find_by_code(params[:code])

    @page_heading = 'Interface: ' + @interface.code

    return unless request.post?

    if @interface.update_attributes(params[:interface])
      flash[:notice] = 'Interface was successfully updated.'

      redirect_to(:action => 'show', 
                  :node_code => @interface.host.node.code,
                  :hostname => @interface.host.name,
                  :code => @interface.code)
    end
  end

  def destroy
    host = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname])
    interface = host.interfaces.find_by_code(params[:code])
    interface.destroy

    flash[:notice] = 'Interface was successfully destroyed.'

    redirect_to(:controller => 'host',
                :action => 'show',
                :node_code => host.node.code,
                :hostname => host.name)
  end

  def wireless
    @interface = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname]).interfaces.find_by_code(params[:code])
    if @interface.wireless_interface
      @wireless_interface = @interface.wireless_interface
    else
      @wireless_interface = WirelessInterface.new params[:wireless_interface]
      @wireless_interface.interface = @interface
    end

    @page_heading = 'Wireless interface properties: ' + @interface.code

    return unless request.method == :post

    if @interface.wireless_interface
      if @wireless_interface.update_attributes(params[:wireless_interface])
        flash[:notice] = 'Interface wireless properties successfully set.'

        redirect_to(:action => 'show',
                    :node_code => @interface.host.node.code,
                    :hostname => @interface.host.name,
                    :code => @interface.code)
      end
    else
      if @wireless_interface.save
        flash[:notice] = 'Interface wireless properties successfully set.'

        redirect_to(:action => 'show',
                    :node_code => @interface.host.node.code,
                    :hostname => @interface.host.name,
                    :code => @interface.code)
      end
    end
  end
end
