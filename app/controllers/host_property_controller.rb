#--
# $Id: host_property_controller.rb 2753 2006-06-16 08:57:06Z keegan $
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

class HostPropertyController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @host_property = HostProperty.find(params[:id])

    @page_heading = 'Host property: ' + @host_property.type.code
  end

  def new
    @host_property = HostProperty.new(params[:host_property])
    @host_property.host = Host.find params[:host_id]

    @page_heading = 'New host property'

    return unless request.post?

    if @host_property.save
      flash[:notice] = 'Host property was successfully created.'
      redirect_to(:controller => 'host',
                  :action => 'show',
                  :node_code => @host_property.host.node.code,
                  :hostname => @host_property.host.name)
    end
  end

  def edit
    @host_property = HostProperty.find(params[:id])

    @page_heading = 'Host property: ' + @host_property.type.code

    return unless request.post?

    if @host_property.update_attributes(params[:host_property])
      flash[:notice] = 'Host property was successfully updated.'
      redirect_to :action => 'show', :id => @host_property.id
    end
  end

  def destroy
    host_property = HostProperty.find(params[:id])
    host = host_property.host
    host_property.destroy
    flash[:notice] = 'Host property was successfully destroyed.'
    redirect_to(:controller => 'host',
                :action => 'show',
                :node_code => host.node.code,
                :hostname => host.name)
  end
end
