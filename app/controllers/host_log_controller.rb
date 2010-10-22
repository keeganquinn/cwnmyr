#--
# $Id: host_log_controller.rb 2575 2006-04-26 21:15:05Z keegan $
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

class HostLogController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @host_log = HostLog.find(params[:id])

    unless logged_in? or @host_log.active?
      redirect_to(:controller => 'welcome') and return
    end

    @page_heading = 'Host log entry: ' + @host_log.subject
  end

  def new
    @host_log = HostLog.new(params[:host_log])
    @host_log.host = Host.find params[:host_id]
    @host_log.user = current_user

    @page_heading = 'New host log entry'

    return unless request.post?

    if @host_log.save
      flash[:notice] = 'Host log entry was successfully created.'
      redirect_to(:controller => 'host',
                  :action => 'show',
                  :node_code => @host_log.host.node.code,
                  :hostname => @host_log.host.name)
    end
  end

  def edit
    @host_log = HostLog.find(params[:id])

    @page_heading = 'Host log entry: ' + @host_log.subject

    return unless request.post?

    if @host_log.update_attributes(params[:host_log])
      flash[:notice] = 'Host log entry was successfully updated.'
      redirect_to :action => 'show', :id => @host_log.id
    end
  end

  def destroy
    host_log = HostLog.find(params[:id])
    host = host_log.host
    host_log.destroy
    flash[:notice] = 'Host log entry was successfully destroyed.'
    redirect_to(:controller => 'host',
                :action => 'show',
                :node_code => host.node.code,
                :hostname => host.name)
  end
end
