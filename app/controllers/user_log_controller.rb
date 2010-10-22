#--
# $Id: user_log_controller.rb 2561 2006-04-22 15:52:07Z keegan $
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

class UserLogController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @user_log = UserLog.find(params[:id])

    unless (current_user == @user_log.user) or @user_log.active?
      redirect_to(:controller => 'welcome') and return
    end

    @page_heading = 'Log entry: ' + @user_log.subject
  end

  def new
    @user_log = UserLog.new(params[:user_log])
    @user_log.user = current_user

    @page_heading = 'New log entry'

    return unless request.post?

    if @user_log.save
      flash[:notice] = 'Log entry was successfully created.'
      redirect_to :controller => 'welcome'
    end
  end

  def edit
    @user_log = current_user.logs.find(params[:id])

    @page_heading = 'Log entry: ' + @user_log.subject

    return unless request.post?

    if @user_log.update_attributes(params[:user_log])
      flash[:notice] = 'Log entry was successfully updated.'
      redirect_to :action => 'show', :id => @user_log.id
    end
  end

  def destroy
    current_user.logs.find(params[:id]).destroy
    flash[:notice] = 'Log entry was successfully destroyed.'
    redirect_to :controller => 'welcome'
  end
end
