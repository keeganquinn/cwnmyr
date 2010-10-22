#--
# $Id: host_property_types_controller.rb 514 2007-07-18 18:25:55Z keegan $
# Copyright 2006-2007 Keegan Quinn
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

# This controller allows the management of HostPropertyType records.
class HostPropertyTypesController < ApplicationController
  before_filter :login_required
  before_filter :load_host_property_type, :except => [ :index, :create, :new ]

  protected

  # Load a HostPropertyType record as an instance variable based on the
  # identifier provided as a request parameter. This method is usually called
  # as a before_filter.
  def load_host_property_type
    @host_property_type = HostPropertyType.find_by_param(params[:id])
    redirect_to(host_property_types_path) and return false unless @host_property_type
  end

  # This method is called by login_required to determine if the current
  # authenticated session is authorized to access actions in this controller.
  helper_method :authorized?
  def authorized?(user)
    user.has_role?(Role.manager)
  end

  public

  # Display a list of HostPropertyType records.
  def index
    @host_property_types = HostPropertyType.paginate :page => params[:page]

    respond_to do |format|
      format.html
      format.xml  { render :xml => @host_property_types.to_xml }
    end
  end

  # Display a single HostPropertyType record.
  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @host_property_type.to_xml }
    end
  end

  # Display a form to allow data for a new HostPropertyType to be provided.
  def new
    @host_property_type = HostPropertyType.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # Display a form for editing a HostPropertyType record.
  def edit
  end

  # Create a new HostPropertyType.
  def create
    @host_property_type = HostPropertyType.new(params[:host_property_type])

    respond_to do |format|
      if @host_property_type.save
        flash[:notice] = t('host property type create success')

        format.html {
          redirect_to host_property_type_path(@host_property_type)
        }
        format.xml  {
          head :created, :location => host_property_type_path(@host_property_type)
        }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @host_property_type.errors.to_xml }
      end
    end
  end

  # Update an existing HostPropertyType.
  def update
    respond_to do |format|
      if @host_property_type.update_attributes(params[:host_property_type])
        flash[:notice] = t('host property type update success')

        format.html { redirect_to host_property_type_path }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @host_property_type.errors.to_xml }
      end
    end
  end

  # Destroy a HostPropertyType.
  def destroy
    @host_property_type.destroy

    flash[:notice] = t('host property type destroy success')

    respond_to do |format|
      format.html { redirect_to host_property_types_path }
      format.xml  { head :ok }
    end
  end
end
