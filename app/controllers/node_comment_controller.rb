#--
# $Id: node_comment_controller.rb 2575 2006-04-26 21:15:05Z keegan $
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

class NodeCommentController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @node_comment = NodeComment.find(params[:id])

    unless logged_in? or @node_comment.active?
      redirect_to(:controller => 'welcome') and return
    end

    @page_heading = 'Node comment: ' + @node_comment.subject
  end

  def new
    @node_comment = NodeComment.new(params[:node_comment])
    @node_comment.node = Node.find params[:node_id]
    @node_comment.user = current_user

    @page_heading = 'New node comment'

    return unless request.post?

    if @node_comment.save
      flash[:notice] = 'Node comment was successfully created.'
      redirect_to :controller => 'node', :action => 'show',
        :code => @node_comment.node.code
    end
  end

  def edit
    @node_comment = NodeComment.find(params[:id])

    @page_heading = 'Node comment: ' + @node_comment.subject

    return unless request.post?

    if @node_comment.update_attributes(params[:node_comment])
      flash[:notice] = 'Node comment was successfully updated.'
      redirect_to :action => 'show', :id => @node_comment.id
    end
  end

  def destroy
    node_comment = NodeComment.find(params[:id])
    node = node_comment.node
    node_comment.destroy
    flash[:notice] = 'Node comment was successfully destroyed.'
    redirect_to :controller => 'node', :action => 'show', :code => node.code
  end
end
