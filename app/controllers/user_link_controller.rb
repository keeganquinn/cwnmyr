#--
# $Id: user_link_controller.rb 2561 2006-04-22 15:52:07Z keegan $
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

class UserLinkController < ApplicationController
  before_filter :login_required

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @user_link = UserLink.find(params[:id])

    unless (current_user == @user_link.user) or @user_link.active?
      redirect_to(:controller => 'welcome') and return
    end

    @page_heading = 'Link: ' + @user_link.name
  end

  def new
    @user_link = UserLink.new(params[:user_link])
    @user_link.user = current_user

    @page_heading = 'New link'

    return unless request.post?

    if @user_link.save
      flash[:notice] = 'Link was successfully created.'
      redirect_to :controller => 'welcome'
    end
  end

  def edit
    @user_link = current_user.links.find(params[:id])

    @page_heading = 'Link: ' + @user_link.name

    return unless request.post?

    if @user_link.update_attributes(params[:user_link])
      flash[:notice] = 'Link was successfully updated.'
      redirect_to :action => 'show', :id => @user_link.id
    end
  end

  def destroy
    current_user.links.find(params[:id]).destroy
    flash[:notice] = 'Link was successfully destroyed.'
    redirect_to :controller => 'welcome'
  end
end
