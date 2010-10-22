#--
# $Id: node_maintainer_controller.rb 2714 2006-06-06 12:11:40Z keegan $
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

class NodeMaintainerController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @node_maintainer = NodeMaintainer.find(params[:id])

    @page_heading = 'Node maintainer: ' + @node_maintainer.maintainer.login
  end

  def new
    @node_maintainer = NodeMaintainer.new(params[:node_maintainer])
    @node_maintainer.node = Node.find params[:node_id]

    @users = User.find(:all)
    @node_maintainer.node.maintainers.each do |existing_node_maintainer|
      @users.delete(existing_node_maintainer.maintainer)
    end

    @page_heading = 'New node maintainer'

    return unless request.post?

    if @node_maintainer.save
      flash[:notice] = 'Node maintainer was successfully created.'

      redirect_to(:controller => 'node',
                  :action => 'show',
                  :code => @node_maintainer.node.code)
    end
  end

  def edit
    @node_maintainer = NodeMaintainer.find(params[:id])

    @users = User.find(:all)
    @node_maintainer.node.maintainers.each do |existing_node_maintainer|
      @users.delete(existing_node_maintainer.maintainer)
    end

    @page_heading = 'Node maintainer: ' + @node_maintainer.maintainer.login

    return unless request.post?

    if @node_maintainer.update_attributes(params[:node_maintainer])
      flash[:notice] = 'Node maintainer was successfully updated.'
      redirect_to :action => 'show', :id => @node_maintainer.id
    end
  end

  def destroy
    node_maintainer = NodeMaintainer.find(params[:id])
    node = node_maintainer.node
    node_maintainer.destroy
    flash[:notice] = 'Node maintainer was successfully destroyed.'
    redirect_to(:controller => 'node', :action => 'show', :code => node.code)
  end
end
