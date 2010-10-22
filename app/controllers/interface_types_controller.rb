#--
# $Id: interface_types_controller.rb 514 2007-07-18 18:25:55Z keegan $
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

class InterfaceTypesController < ApplicationController
  before_filter :login_required, :except => [ :index, :show ]
  before_filter :load_interface_type, :except => [ :index, :create, :new ]

  protected

  # Load an InterfaceType record as an instance variable based on the
  # identifier provided as a request parameter. This method is usually called
  # as a before_filter.
  def load_interface_type
    @interface_type = InterfaceType.find_by_param(params[:id])
    redirect_to(interface_types_path) and return false unless @interface_type
  end

  public

  # Display a list of InterfaceType records.
  def index
    @interface_types = InterfaceType.paginate :page => params[:page]

    respond_to do |format|
      format.html
      format.xml  { render :xml => @interface_types.to_xml }
    end
  end

  # Display a single InterfaceType record.
  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @interface_type.to_xml }
    end
  end

  # Display a form to allow data for a new InterfaceType to be provided.
  def new
    @interface_type = InterfaceType.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # Display a new InterfaceType.
  def edit
  end

  # Create a new InterfaceType.
  def create
    @interface_type = InterfaceType.new(params[:interface_type])

    respond_to do |format|
      if @interface_type.save
        flash[:notice] = t('interface type create success')

        format.html { redirect_to interface_type_path(@interface_type) }
        format.xml  { head :created, :location => interface_type_path(@interface_type) }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @interface_type.errors.to_xml }
      end
    end
  end

  # Update an existing InterfaceType.
  def update
    respond_to do |format|
      if @interface_type.update_attributes(params[:interface_type])
        flash[:notice] = t('interface type update success')

        format.html { redirect_to interface_type_path }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @interface_type.errors.to_xml }
      end
    end
  end

  # Destroy an InterfaceType.
  def destroy
    @interface_type.destroy

    flash[:notice] = t('interface type destroy success')

    respond_to do |format|
      format.html { redirect_to interface_types_path }
      format.xml  { head :ok }
      format.js   { send_js "interface_type_#{@interface_type.to_param}" }
    end
  end
end
