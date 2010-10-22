#--
# $Id: zone_maintainer_controller.rb 2714 2006-06-06 12:11:40Z keegan $
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

class ZoneMaintainerController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @zone_maintainer = ZoneMaintainer.find(params[:id])

    @page_heading = 'Zone maintainer: ' + @zone_maintainer.maintainer.login
  end

  def new
    @zone_maintainer = ZoneMaintainer.new(params[:zone_maintainer])
    @zone_maintainer.zone = Zone.find params[:zone_id]

    @users = User.find(:all, :order => 'login ASC')
    @zone_maintainer.zone.maintainers.each do |existing_zone_maintainer|
      @users.delete(existing_zone_maintainer.maintainer)
    end

    @page_heading = 'New zone maintainer'

    return unless request.post?

    if @zone_maintainer.save
      flash[:notice] = 'Zone maintainer was successfully created.'

      redirect_to(:controller => 'zone',
                  :action => 'show',
                  :code => @zone_maintainer.zone.code)
    end
  end

  def edit
    @zone_maintainer = ZoneMaintainer.find(params[:id])

    @users = User.find(:all, :order => 'login ASC')
    @zone_maintainer.zone.maintainers.each do |existing_zone_maintainer|
      @users.delete(existing_zone_maintainer.maintainer)
    end

    @page_heading = 'Zone maintainer: ' + @zone_maintainer.maintainer.login

    return unless request.post?

    if @zone_maintainer.update_attributes(params[:zone_maintainer])
      flash[:notice] = 'Zone maintainer was successfully updated.'
      redirect_to :action => 'show', :id => @zone_maintainer.id
    end
  end

  def destroy
    zone_maintainer = ZoneMaintainer.find(params[:id])
    zone = zone_maintainer.zone
    zone_maintainer.destroy
    flash[:notice] = 'Zone maintainer was successfully destroyed.'
    redirect_to(:controller => 'zone', :action => 'show', :code => zone.code)
  end
end
