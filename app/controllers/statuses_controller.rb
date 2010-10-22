#--
# $Id: statuses_controller.rb 514 2007-07-18 18:25:55Z keegan $
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

# This controller allows the management of Status records.
class StatusesController < ApplicationController
  before_filter :login_required
  before_filter :load_status, :except => [ :index, :create, :new ]

  protected

  # Load a Status record as an instance variable based on the identifier
  # provided as a request parameter. This method is usually called as a
  # before_filter.
  def load_status
    @status = Status.find_by_param(params[:id])
    redirect_to(statuses_path) and return false unless @status
  end

  # This method is called by login_required to determine if the current
  # authenticated session is authorized to access actions in this controller.
  helper_method :authorized?
  def authorized?(user)
    user.has_role?(Role.manager)
  end

  public

  # Display a list of Status records.
  def index
    @statuses = Status.paginate :page => params[:page]

    respond_to do |format|
      format.html
      format.xml  { render :xml => @statuses.to_xml }
    end
  end

  # Display a single Status record
  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @status.to_xml }
    end
  end

  # Display a form to allow data for a new Status to be provided.
  def new
    @status = Status.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # Display a form for editing a Status record.
  def edit
  end

  # Create a new Status.
  def create
    @status = Status.new(params[:status])

    respond_to do |format|
      if @status.save
        flash[:notice] = t('status create success')

        format.html { redirect_to status_path(@status) }
        format.xml  { head :created, :location => status_path(@status) }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @status.errors.to_xml }
      end
    end
  end

  # Update an existing Status.
  def update
    respond_to do |format|
      if @status.update_attributes(params[:status])
        flash[:notice] = t('status update success')

        format.html { redirect_to status_path }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @status.errors.to_xml }
      end
    end
  end

  # Destroy a Status.
  def destroy
    @status.destroy

    flash[:notice] = t('status destroy success')

    respond_to do |format|
      format.html { redirect_to statuses_path }
      format.xml  { head :ok }
    end
  end
end
