#--
# $Id: host_type_comment_controller.rb 2641 2006-05-20 06:39:19Z keegan $
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

class HostTypeCommentController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @host_type_comment = HostTypeComment.find(params[:id])

    unless logged_in? or @host_type_comment.active?
      redirect_to(:controller => 'welcome') and return
    end

    @page_heading = 'Host type comment: ' + @host_type_comment.subject
  end

  def new
    @host_type_comment = HostTypeComment.new(params[:host_type_comment])
    @host_type_comment.host_type = HostType.find params[:host_type_id]
    @host_type_comment.user = current_user

    @page_heading = 'New host type comment'

    return unless request.post?

    if @host_type_comment.save
      flash[:notice] = 'Host type comment was successfully created.'
      redirect_to :controller => 'host_type', :action => 'show',
        :code => @host_type_comment.host_type.code
    end
  end

  def edit
    @host_type_comment = HostTypeComment.find(params[:id])

    @page_heading = 'Host type comment: ' + @host_type_comment.subject

    return unless request.post?

    if @host_type_comment.update_attributes(params[:host_type_comment])
      flash[:notice] = 'Host type comment was successfully updated.'
      redirect_to :action => 'show', :id => @host_type_comment.id
    end
  end

  def destroy
    host_type_comment = HostTypeComment.find(params[:id])
    host_type = host_type_comment.host_type
    host_type_comment.destroy
    flash[:notice] = 'Host type comment was successfully destroyed.'
    redirect_to(:controller => 'host_type',
                :action => 'show',
                :code => host_type.code)
  end
end
