#--
# $Id: zones_controller.rb 514 2007-07-18 18:25:55Z keegan $
# Copyright 2004-2007 Keegan Quinn
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

# This controller allows the management of Zone records.
class ZonesController < ApplicationController
  before_filter :login_required, :except => [ :index, :show ]
  before_filter :load_zone, :except => [ :index, :create, :new ]

  protected

  # Load a Zone record as an instance variable based on the identifier
  # provided as a request parameter.  This method is usually called as a
  # before_filter.
  def load_zone
    @zone = Zone.find_by_param(params[:id])
    redirect_to(zones_path) and return false unless @zone
  end

  public

  # Display a list of Zone records.
  def index
    @zones = Zone.paginate :page => params[:page]

    respond_to do |format|
      format.html
      format.xml  { render :xml => @zones.to_xml }
    end
  end

  # Display a single Zone record.
  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @zone.to_xml }
    end
  end

  # Display a form to allow data for a new Zone to be provided.
  def new
    @zone = Zone.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # Display a form for editing a Zone record.
  def edit
  end

  # Create a new Zone.
  def create
    @zone = Zone.new(params[:zone])

    respond_to do |format|
      if @zone.save
        flash[:notice] = t('zone create success')

        format.html { redirect_to zone_path(@zone) }
        format.xml  { head :created, :location => zone_path(@zone) }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @zone.errors.to_xml }
      end
    end
  end

  # Update an existing Zone.
  def update
    respond_to do |format|
      if @zone.update_attributes(params[:zone])
        flash[:notice] = t('zone update success')

        format.html { redirect_to zone_path }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @zone.errors.to_xml }
      end
    end
  end

  # Destroy a Zone.
  def destroy
    @zone.destroy

    flash[:notice] = t('zone destroy success')

    respond_to do |format|
      format.html { redirect_to zones_path }
      format.xml  { head :ok }
      format.js   { send_js "zone_#{@zone.to_param}" }
    end
  end
end
