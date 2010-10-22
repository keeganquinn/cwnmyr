#--
# $Id: interface_property_types_controller.rb 514 2007-07-18 18:25:55Z keegan $
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

# This controller allows the management of InterfacePropertyType records.
class InterfacePropertyTypesController < ApplicationController
  before_filter :login_required
  before_filter :load_interface_property_type,
    :except => [ :index, :create, :new ]

  protected

  # Load an InterfacePropertyType record as an instance variable based on the
  # identifier provided as a request parameter. This method is usually called
  # as a before_filter.
  def load_interface_property_type
    @interface_property_type = InterfacePropertyType.find_by_param(params[:id])
    redirect_to(interface_property_types_path) and return false unless @interface_property_type
  end

  # This method is called by login_required to determine if the current
  # authenticated session is authorized to access actions in this controller.
  helper_method :authorized?
  def authorized?(user)
    user.has_role?(Role.manager)
  end

  public

  # Display a list of InterfacePropertyType records.
  def index
    @interface_property_types = InterfacePropertyType.paginate :page => params[:page]

    respond_to do |format|
      format.html
      format.xml  { render :xml => @interface_property_types.to_xml }
    end
  end

  # Display a single InterfacePropertyType record.
  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @interface_property_type.to_xml }
    end
  end

  # Display a form to allow data for a new InterfacePropertyType to be
  # provided.
  def new
    @interface_property_type = InterfacePropertyType.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # Display a form for editing an InterfacePropertyType record.
  def edit
  end

  # Create a new InterfacePropertyType.
  def create
    @interface_property_type = InterfacePropertyType.new(params[:interface_property_type])

    respond_to do |format|
      if @interface_property_type.save
        flash[:notice] = t('interface property type create success')

        format.html {
          redirect_to interface_property_type_path(@interface_property_type)
        }
        format.xml {
          head :created, :location => interface_property_type_path(@interface_property_type)
        }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @interface_property_type.errors.to_xml }
      end
    end
  end

  # Update an existing InterfacePropertyType.
  def update
    respond_to do |format|
      if @interface_property_type.update_attributes(params[:interface_property_type])
        flash[:notice] = t('interface property type update success')

        format.html { redirect_to interface_property_type_path }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @interface_property_type.errors.to_xml }
      end
    end
  end

  # Destroy an InterfacePropertyType.
  def destroy
    @interface_property_type.destroy

    flash[:notice] = t('interface property type destroy success')

    respond_to do |format|
      format.html { redirect_to interface_property_types_path }
      format.xml  { head :ok }
    end
  end
end
