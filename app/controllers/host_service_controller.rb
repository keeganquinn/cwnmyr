#--
# $Id: host_service_controller.rb 2575 2006-04-26 21:15:05Z keegan $
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

class HostServiceController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @host_service = HostService.find(params[:id])

    @page_heading = 'Host service: ' + @host_service.service.name
  end

  def new
    @host_service = HostService.new(params[:host_service])
    @host_service.host = Host.find params[:host_id]

    @services = Service.find_all_by_expose(true)
    @host_service.host.services.each do |existing_host_service|
      @services.delete(existing_host_service.service)
    end

    @page_heading = 'New host service'

    return unless request.post?

    if @host_service.save
      flash[:notice] = 'Host service was successfully created.'
      redirect_to(:controller => 'host',
                  :action => 'show',
                  :node_code => @host_service.host.node.code,
                  :hostname => @host_service.host.name)
    end
  end

  def edit
    @host_service = HostService.find(params[:id])

    @services = Service.find_all_by_expose(true)
    @host_service.host.services.each do |existing_host_service|
      @services.delete(existing_host_service.service)
    end

    @page_heading = 'Host service: ' + @host_service.service.name

    return unless request.post?

    if @host_service.update_attributes(params[:host_service])
      flash[:notice] = 'Host service was successfully updated.'
      redirect_to :action => 'show', :id => @host_service.id
    end
  end

  def destroy
    host_service = HostService.find(params[:id])
    host = host_service.host
    host_service.destroy
    flash[:notice] = 'Host service was successfully destroyed.'
    redirect_to(:controller => 'host',
                :action => 'show',
                :node_code => host.node.code,
                :hostname => host.name)
  end
end
