#--
# $Id: node_log_controller.rb 2575 2006-04-26 21:15:05Z keegan $
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

class NodeLogController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @node_log = NodeLog.find(params[:id])

    unless logged_in? or @node_log.active?
      redirect_to(:controller => 'welcome') and return
    end

    @page_heading = 'Node log entry: ' + @node_log.subject
  end

  def new
    @node_log = NodeLog.new(params[:node_log])
    @node_log.node = Node.find params[:node_id]
    @node_log.user = current_user

    @page_heading = 'New node log entry'

    return unless request.post?

    if @node_log.save
      flash[:notice] = 'Node log entry was successfully created.'
      redirect_to :controller => 'node', :action => 'show',
        :code => @node_log.node.code
    end
  end

  def edit
    @node_log = NodeLog.find(params[:id])

    @page_heading = 'Node log entry: ' + @node_log.subject

    return unless request.post?

    if @node_log.update_attributes(params[:node_log])
      flash[:notice] = 'Node log entry was successfully updated.'
      redirect_to :action => 'show', :id => @node_log.id
    end
  end

  def destroy
    node_log = NodeLog.find(params[:id])
    node = node_log.node
    node_log.destroy
    flash[:notice] = 'Node log entry was successfully destroyed.'
    redirect_to :controller => 'node', :action => 'show', :code => node.code
  end
end
