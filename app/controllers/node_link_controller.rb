#--
# $Id: node_link_controller.rb 2561 2006-04-22 15:52:07Z keegan $
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

class NodeLinkController < ApplicationController
  before_filter :login_required

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @node_link = NodeLink.find(params[:id])

    unless logged_in? or @node_link.active?
      redirect_to(:controller => 'welcome') and return
    end

    @page_heading = 'Node link: ' + @node_link.name
  end

  def new
    @node_link = NodeLink.new(params[:node_link])
    @node_link.node = Node.find params[:node_id]

    @page_heading = 'New node link'

    return unless request.post?

    if @node_link.save
      flash[:notice] = 'Node link was successfully created.'
      redirect_to :controller => 'node', :action => 'show',
        :code => @node_link.node.code
    end
  end

  def edit
    @node_link = NodeLink.find(params[:id])

    @page_heading = 'Node link: ' + @node_link.name

    return unless request.post?

    if @node_link.update_attributes(params[:node_link])
      flash[:notice] = 'Node link was successfully updated.'
      redirect_to :action => 'show', :id => @node_link.id
    end
  end

  def destroy
    node_link = NodeLink.find(params[:id])
    node = node_link.node
    node_link.destroy
    flash[:notice] = 'Node link was successfully destroyed.'
    redirect_to :controller => 'node', :action => 'show', :code => node.code
  end
end
