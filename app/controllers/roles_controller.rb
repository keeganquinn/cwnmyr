#--
# $Id: roles_controller.rb 514 2007-07-18 18:25:55Z keegan $
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

# This controller allows the management of Role records.
class RolesController < ApplicationController
  before_filter :login_required
  before_filter :load_role, :except => [ :index, :create, :new ]

  protected

  # Load a Role record as an instance variable based on the identifier
  # provided as a request parameter.  This method is usually called as a
  # before_filter.
  def load_role
    @role = Role.find_by_param(params[:id])
    redirect_to(roles_path) and return false unless @role
  end

  # This method is called by login_required to determine if the current
  # authenticated session is authorized to access actions in this controller.
  helper_method :authorized?
  def authorized?(user)
    user.has_role?(Role.manager)
  end

  public

  # Display a list of Role records.
  def index
    @roles = Role.paginate :page => params[:page]

    respond_to do |format|
      format.html
      format.xml  { render :xml => @roles.to_xml }
    end
  end

  # Display a single Role record.
  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @role.to_xml }
    end
  end

  # Display a form to allow data for a new Role to be provided.
  def new
    @role = Role.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # Display a form for editing a Role record.
  def edit
  end

  # Create a new Role.
  def create
    @role = Role.new(params[:role])

    respond_to do |format|
      if @role.save
        flash[:notice] = t('role create success')

        format.html { redirect_to role_path(@role) }
        format.xml  { head :created, :location => role_path(@role) }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @role.errors.to_xml }
      end
    end
  end

  # Update an existing Role.
  def update
    respond_to do |format|
      if @role.update_attributes(params[:role])
        flash[:notice] = t('role update success')

        format.html { redirect_to role_path }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @role.errors.to_xml }
      end
    end
  end

  # Destroy a Role.
  def destroy
    @role.destroy

    flash[:notice] = t('role destroy success')

    respond_to do |format|
      format.html { redirect_to roles_path }
      format.xml  { head :ok }
      format.js   { send_js "role_#{@role.to_param}" }
    end
  end
end
