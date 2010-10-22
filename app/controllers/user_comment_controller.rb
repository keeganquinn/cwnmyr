#--
# $Id: user_comment_controller.rb 2561 2006-04-22 15:52:07Z keegan $
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

class UserCommentController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @user_comment = UserComment.find(params[:id])

    unless (current_user == @user_comment.commenting_user) or
        @user_comment.active?
      redirect_to(:controller => 'welcome') and return
    end

    @page_heading = 'Comment: ' + @user_comment.subject
  end

  def new
    @user_comment = UserComment.new(params[:user_comment])
    @user_comment.user = User.find(params[:user_id])
    @user_comment.commenting_user = current_user

    @page_heading = 'New comment'

    return unless request.post?

    if @user_comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to(:controller => 'user',
                  :action => 'show',
                  :login => @user_comment.user.login)
    end
  end

  def edit
    @user_comment = current_user.comments_on_others.find(params[:id])

    @page_heading = 'Comment: ' + @user_comment.subject

    return unless request.post?

    if @user_comment.update_attributes(params[:user_comment])
      flash[:notice] = 'Comment was successfully updated.'
      redirect_to :action => 'show', :id => @user_comment.id
    end
  end

  def destroy
    current_user.comments_on_others.find(params[:id]).destroy
    flash[:notice] = 'Comment was successfully destroyed.'
    redirect_to :controller => 'welcome'
  end
end
